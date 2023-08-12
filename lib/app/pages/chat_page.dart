import 'package:clean_chat/app/data/mock/chats_data.dart';
import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/models/message_model.dart';
import 'package:clean_chat/app/shared/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.contact});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        toolbarHeight: 75,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        title: Row(
          children: [
            //AVATAR
            Badge(
              alignment: Alignment.bottomRight,
              smallSize: 15,
              backgroundColor:
                  contact.isOnline ? Colors.green : const Color(0xffcacaca),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Container(
                  color: Colors.deepPurple,
                  height: 50,
                  child: Image.asset(
                    contact.avatarUrl,
                  ),
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            //TEXTS
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contact.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  contact.isOnline ? "Online" : "Offline",
                  style: TextStyle(
                    fontSize: 14,
                    color: contact.isOnline ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.video_call_rounded,
              size: 40,
            ),
            color: const Color(0xffcacaca),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.call_rounded,
              size: 30,
            ),
            color: const Color(0xffcacaca),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder(
                stream: ChatsData().getMockedMessageStream(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );

                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        return const Text(
                          'Algo deu errado, tente novamente mais tarde.',
                        );
                      } else if (snapshot.hasData) {
                        List<MessageModel> messages =
                            (snapshot.data as List<MessageModel>);
                        return ListView.builder(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 10),
                          itemCount: messages.length,
                          itemBuilder: (context, index) =>
                              MessageCard(message: messages[index]),
                        );
                      } else {
                        return const Text(
                          'Algo deu errado, tente novamente mais tarde.',
                        );
                      }
                    default:
                      return const Text(
                        'Algo deu errado, tente novamente mais tarde.',
                      );
                  }
                },
              ),
            ),
            Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: const Color(0xffcacaca),
                          ),
                          cursorColor: const Color(0xffcacaca),
                          decoration: const InputDecoration(
                            hintText: 'Digite aqui...',
                            hintStyle: TextStyle(color: Color(0xffcacaca)),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      color: const Color(0xffcacaca),
                      width: 1,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xffcacaca),
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Color(0xffcacaca),
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
