// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? message;
  final DateTime date;
  final String uid;
  final String? imageUrl;
  final bool wasViewed;

  MessageModel({
    this.message,
    required this.date,
    required this.uid,
    this.imageUrl,
    required this.wasViewed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'date': date.millisecondsSinceEpoch,
      'uid': uid,
      'imageUrl': imageUrl,
      'wasViewed': wasViewed,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] != null ? map['message'] as String : null,
      date: (map['date'] as Timestamp).toDate(),
      uid: map['uid'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      wasViewed: map['wasViewed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
