class ContactModel {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final DateTime lastEntry;
  final String lastMessage;
  final bool haveUnreadMessages;
  final bool isOnline;
  final bool lastMessageIsMy;

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
}
