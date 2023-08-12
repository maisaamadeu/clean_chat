import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final ContactModel contact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatPage(contact: contact),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //AVATAR
                  Badge(
                    alignment: Alignment.bottomRight,
                    smallSize: 15,
                    backgroundColor: contact.isOnline
                        ? Colors.green
                        : const Color(0xffcacaca),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Container(
                        color: Colors.deepPurple,
                        height: 70,
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
                    children: [
                      Text(
                        contact.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          contact.lastMessageIsMy
                              ? Container(
                                  margin: const EdgeInsets.only(
                                    right: 5,
                                  ),
                                  child: const Icon(
                                    Icons.done_all_rounded,
                                    size: 15,
                                    color: Color.fromARGB(255, 132, 132, 132),
                                  ),
                                )
                              : Container(),
                          Text(
                            contact.lastMessage,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 132, 132, 132),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              //LAST ENTRY DATE
              Text(
                DateFormat.jm().format(contact.lastEntry).toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
