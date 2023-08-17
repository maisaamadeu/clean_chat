// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime lastEntry;
  final String? lastMessage;
  final bool? haveUnreadMessages;
  final bool? isOnline;
  final bool? lastMessageIsMy;

  ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.lastEntry,
    required this.lastMessage,
    required this.haveUnreadMessages,
    required this.isOnline,
    required this.lastMessageIsMy,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'lastEntry': lastEntry.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
      'haveUnreadMessages': haveUnreadMessages,
      'isOnline': isOnline,
      'lastMessageIsMy': lastMessageIsMy,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatarUrl'] as String,
      lastEntry: DateTime.fromMillisecondsSinceEpoch(map['lastEntry'] as int),
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
