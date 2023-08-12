class MessageModel {
  final String? message;
  final DateTime date;
  final String userId;
  final String? imageUrl;
  final bool wasViewed;

  MessageModel({
    this.message,
    required this.date,
    required this.userId,
    this.imageUrl,
    required this.wasViewed,
  });
}
