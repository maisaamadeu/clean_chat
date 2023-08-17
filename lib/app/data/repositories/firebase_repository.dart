import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/models/message_model.dart';
import 'package:clean_chat/app/data/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseRepository {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> initFirebase() async {
    await _firebaseService.initFirebase();
  }

  Future<User?> getCurrentUser() async {
    return await _firebaseService.getCurrentUser();
  }

  Future<User?> signIn({required BuildContext context}) async {
    return await _firebaseService.signInWithGoogle(context: context);
  }

  Future<void> updateDataUser(User user) async {
    await _firebaseService.updateDataUser(user);
  }

  Future<void> signOut({required BuildContext context}) async {
    await _firebaseService.signOut(context: context);
  }

  Future<List<ContactModel?>> getContacts() async {
    return await _firebaseService.getContacts();
  }

  Future<List<MessageModel?>> getChat() async {
    return await _firebaseService.getChat();
  }

  Future<void> addContact() async {
    await _firebaseService.addContact();
  }
}
