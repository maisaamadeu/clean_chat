// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String uid;
  String name;
  String email;
  String photoUrl;
  DateTime lastEntry;
  String? lastMessage;
  bool? haveUnreadMessages;
  bool? isOnline;
  bool? lastMessageIsMy;

  ContactModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.lastEntry,
    this.lastMessage,
    this.haveUnreadMessages,
    this.isOnline,
    this.lastMessageIsMy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'lastEntry': lastEntry.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'haveUnreadMessages': haveUnreadMessages,
      'isOnline': isOnline,
      'lastMessageIsMy': lastMessageIsMy,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      uid: map['uid'] as String,
      name: map['displayName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      lastEntry: (map['lastEntry'] as Timestamp).toDate(),
      lastMessage:
          map['lastMessage'] != null ? map['lastMessage'] as String : null,
      haveUnreadMessages: map['haveUnreadMessages'] != null
          ? map['haveUnreadMessages'] as bool
          : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
      lastMessageIsMy: map['lastMessageIsMy'] != null
          ? map['lastMessageIsMy'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
