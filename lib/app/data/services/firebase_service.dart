// ignore_for_file: use_build_context_synchronously

import 'package:clean_chat/app/data/mock/chats_data.dart';
import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/models/message_model.dart';
import 'package:clean_chat/app/pages/start_page.dart';
import 'package:clean_chat/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  Future<void> initFirebase() async {
    if (Firebase.apps.isEmpty) {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  Future<User?> getCurrentUser() async {
    if (Firebase.apps.isEmpty) await initFirebase();
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    } else {
      return currentUser;
    }
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'The account already exists with a different credential.',
              ),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'Error occurred while accessing credentials. Try again.',
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error occurred using Google Sign-In. Try again.',
            ),
          );
        }
      }
    }

    if (user != null) {
      createUserCollection(user);
    }

    return user;
  }

  Future<void> createUserCollection(User user) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final existingData = await userRef.get();

    if (existingData.exists) {
      await userRef.update({
        'lastEntry': FieldValue.serverTimestamp(),
        'isOnline': true,
      });
    } else {
      await userRef.set({
        'displayName': user.displayName,
        'email': user.email,
        'photoUrl': user.photoURL,
        'uid': user.uid,
        'lastEntry': FieldValue.serverTimestamp(),
        'contacts': [],
        'isOnline': true,
      });
    }
  }

  Future<void> updateDataUser(User user) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
    final existingData = await userRef.get();

    if (existingData.exists) {
      await userRef.update({
        'lastEntry': FieldValue.serverTimestamp(),
        'isOnline': true,
      });
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }

      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const StartPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  Future<List<ContactModel?>> getContacts() async {
    final List<ContactModel?> contactsModels = [];
    User? user = await getCurrentUser();
    if (user == null) {
      return [];
    }
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    final DocumentSnapshot documentSnapshot = await userRef.get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;

      final List<dynamic> contactsUID = data['contacts'];

      for (var contact in contactsUID) {
        final userRefContact =
            FirebaseFirestore.instance.collection('users').doc(contact);

        final DocumentSnapshot documentSnapshotContact =
            await userRefContact.get();

        Map<String, dynamic> contactData =
            documentSnapshotContact.data() as Map<String, dynamic>;

        ContactModel newContactModel = ContactModel.fromMap(contactData);

        List<String> uids = [user.uid, newContactModel.uid];

        uids.sort();

        final userRefContactMessages = FirebaseFirestore.instance
            .collection('chats')
            .doc('${uids.first}_${uids.last}');

        final DocumentSnapshot documentSnapshotContactMessages =
            await userRefContactMessages.get();

        if (documentSnapshotContactMessages.exists) {
          Map<String, dynamic> messages =
              documentSnapshotContactMessages.data() as Map<String, dynamic>;

          if (messages.isNotEmpty) {
            List<Map<String, dynamic>> messagesSorted =
                List.from(messages['messages']);
            messagesSorted.sort((a, b) {
              Timestamp timestampA = a['date'];
              Timestamp timestampB = b['date'];
              DateTime dateTimeA = timestampA.toDate();
              DateTime dateTimeB = timestampB.toDate();
              return dateTimeB.compareTo(dateTimeA);
            });

            newContactModel.lastMessage =
                (messagesSorted.first['message'] != '' &&
                        messagesSorted.first['message'] != null
                    ? messagesSorted.first['message']
                    : (messagesSorted.first['imageUrl'] != '' &&
                            messagesSorted.first['imageUrl'] != null
                        ? messagesSorted.first['imageUrl']
                        : null));

            newContactModel.lastMessageIsMy =
                messagesSorted.first['uid'] == user.uid;

            newContactModel.haveUnreadMessages =
                newContactModel.lastMessageIsMy!
                    ? false
                    : messagesSorted.first['wasViewed'];
          }
        }

        contactsModels.add(newContactModel);
      }
    }

    return contactsModels;
  }

  Stream<List<ContactModel?>> getContactsStream() {
    return Stream.fromFuture(getContacts());
  }

  Future<List<MessageModel?>> getChat({required String friendUid}) async {
    User? user = await getCurrentUser();

    List<String> uids = [user!.uid, friendUid];
    List<MessageModel> messagesModels = [];

    uids.sort();

    final userRefContactMessages = FirebaseFirestore.instance
        .collection('chats')
        .doc('${uids.first}_${uids.last}');

    final DocumentSnapshot documentSnapshotContactMessages =
        await userRefContactMessages.get();

    if (documentSnapshotContactMessages.exists) {
      Map<String, dynamic> messages =
          documentSnapshotContactMessages.data() as Map<String, dynamic>;

      if (messages.isNotEmpty) {
        List<Map<String, dynamic>> messagesSorted =
            List.from(messages['messages']);
        messagesSorted.sort((a, b) {
          Timestamp timestampA = a['date'];
          Timestamp timestampB = b['date'];
          DateTime dateTimeA = timestampA.toDate();
          DateTime dateTimeB = timestampB.toDate();
          return dateTimeB.compareTo(dateTimeA);
        });

        for (var message in messagesSorted) {
          MessageModel newMessage = MessageModel.fromMap(message);

          messagesModels.add(newMessage);
        }
      }
    }
    messagesModels = messagesModels.reversed.toList();
    return messagesModels;
  }

  Stream<List<MessageModel?>> getChatStream({required String friendUid}) {
    return Stream.fromFuture(getChat(friendUid: friendUid));
  }

  Future<void> addContact() async {}
}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}
