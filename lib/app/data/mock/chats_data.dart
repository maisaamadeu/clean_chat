import 'package:clean_chat/app/data/models/contact_model.dart';

class ChatsData {
  List<ContactModel> getContacts() {
    List<ContactModel> contacts = [
      ContactModel(
        id: "1",
        name: "John Doe",
        email: "john@example.com",
        avatarUrl: "assets/images/black-man.png",
        lastEntry: DateTime.parse("2023-08-08 10:00:00"),
        lastMessage: "Hey there!",
        haveUnreadMessages: true,
        isOnline: false,
        lastMessageIsMy: true,
      ),
      ContactModel(
        id: "2",
        name: "Jane Smith",
        email: "jane@example.com",
        avatarUrl: "assets/images/black-woman.png",
        lastEntry: DateTime.parse("2023-08-07 03:30:00"),
        lastMessage: "Hello!",
        haveUnreadMessages: true,
        isOnline: true,
        lastMessageIsMy: false,
      ),
      ContactModel(
        id: "3",
        name: "Alex Johnson",
        email: "alex@example.com",
        avatarUrl: "assets/images/old-man.png",
        lastEntry: DateTime.parse("2023-08-06 19:15:00"),
        lastMessage: "Good Night!",
        haveUnreadMessages: false,
        isOnline: false,
        lastMessageIsMy: true,
      ),
      ContactModel(
        id: "4",
        name: "Emily Brown",
        email: "emily@example.com",
        avatarUrl: "assets/images/white-woman.png",
        lastEntry: DateTime.parse("2023-08-05 05:45:00"),
        lastMessage: "Bye!",
        haveUnreadMessages: false,
        isOnline: true,
        lastMessageIsMy: false,
      ),
    ];

    return contacts;
  }
}
