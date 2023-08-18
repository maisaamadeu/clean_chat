import 'dart:async';

import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/models/message_model.dart';

class ChatsData {
  List<ContactModel> getContacts() {
    List<ContactModel> contacts = [
      ContactModel(
        uid: "2",
        name: "John Doe",
        email: "john@example.com",
        photoUrl: "assets/images/black-man.png",
        lastEntry: DateTime.parse("2023-08-08 10:00:00"),
        lastMessage: "Hey there!",
        haveUnreadMessages: true,
        isOnline: false,
        lastMessageIsMy: true,
      ),
      ContactModel(
        uid: "3",
        name: "Jane Smith",
        email: "jane@example.com",
        photoUrl: "assets/images/black-woman.png",
        lastEntry: DateTime.parse("2023-08-07 03:30:00"),
        lastMessage: "Hello!",
        haveUnreadMessages: true,
        isOnline: true,
        lastMessageIsMy: false,
      ),
      ContactModel(
        uid: "4",
        name: "Alex Johnson",
        email: "alex@example.com",
        photoUrl: "assets/images/old-man.png",
        lastEntry: DateTime.parse("2023-08-06 19:15:00"),
        lastMessage: "Good Night!",
        haveUnreadMessages: false,
        isOnline: false,
        lastMessageIsMy: true,
      ),
      ContactModel(
        uid: "5",
        name: "Emily Brown",
        email: "emily@example.com",
        photoUrl: "assets/images/white-woman.png",
        lastEntry: DateTime.parse("2023-08-05 05:45:00"),
        lastMessage: "Bye!",
        haveUnreadMessages: false,
        isOnline: true,
        lastMessageIsMy: false,
      ),
    ];

    return contacts;
  }

  Stream<List<MessageModel>> getChat() {
    final controller = StreamController<List<MessageModel>>();

    List<MessageModel> sampleMessages = [
      MessageModel(
        message: "Olá, usuário 2! Como vai?",
        date: DateTime.now().subtract(const Duration(minutes: 55)),
        uid: "1",
        wasViewed: true,
      ),
      MessageModel(
        message: "Oi, usuário 1! Estou bem, obrigado!",
        date: DateTime.now().subtract(const Duration(minutes: 50)),
        uid: "2",
        wasViewed: true,
      ),
      MessageModel(
        message: "Preparado para a reunião de amanhã?",
        date: DateTime.now().subtract(const Duration(minutes: 45)),
        uid: "1",
        wasViewed: true,
      ),
      MessageModel(
        message: "Sim, já revisei os documentos.",
        date: DateTime.now().subtract(const Duration(minutes: 40)),
        uid: "2",
        wasViewed: true,
      ),
      MessageModel(
        message: "Ótimo! Nos vemos lá.",
        date: DateTime.now().subtract(const Duration(minutes: 35)),
        uid: "1",
        wasViewed: true,
      ),
      MessageModel(
        message: "Claro, até amanhã!",
        date: DateTime.now().subtract(const Duration(minutes: 30)),
        uid: "2",
        wasViewed: true,
      ),
      MessageModel(
        message: "Você já pensou em algumas ideias para o projeto?",
        date: DateTime.now().subtract(const Duration(minutes: 25)),
        uid: "1",
        wasViewed: true,
      ),
      MessageModel(
        message: "Sim, tenho algumas ideias interessantes.",
        date: DateTime.now().subtract(const Duration(minutes: 20)),
        uid: "2",
        wasViewed: true,
      ),
      MessageModel(
        message: "Mal posso esperar para ouvi-las!",
        date: DateTime.now().subtract(const Duration(minutes: 15)),
        uid: "1",
        wasViewed: true,
      ),
      MessageModel(
        message: "Vou preparar uma apresentação para compartilhar.",
        date: DateTime.now().subtract(const Duration(minutes: 10)),
        uid: "2",
        wasViewed: true,
      ),
      MessageModel(
        message: "Isso é ótimo! Acho que estamos no caminho certo.",
        date: DateTime.now().subtract(const Duration(minutes: 5)),
        uid: "1",
        wasViewed: false,
      ),
      MessageModel(
        date: DateTime.now().subtract(const Duration(minutes: 0)),
        uid: "1",
        wasViewed: false,
        imageUrl:
            'https://blog-static.petlove.com.br/wp-content/uploads/2020/11/gato-preto-2.jpg',
      ),

      // ... continue adicionando mais mensagens
    ];

    controller.add(sampleMessages);

    return controller.stream;
  }
}
