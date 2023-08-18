import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/repositories/firebase_repository.dart';
import 'package:clean_chat/app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactCard extends StatefulWidget {
  const ContactCard({super.key, required this.contact});

  final ContactModel contact;

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  User? user;

  void getUser() async {
    user = await FirebaseRepository().getCurrentUser();
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                ChatPage(contact: widget.contact, user: user!),
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
                  Hero(
                    tag: widget.contact.photoUrl,
                    child: Badge(
                      alignment: Alignment.bottomRight,
                      smallSize: 15,
                      backgroundColor: widget.contact.isOnline!
                          ? Colors.green
                          : const Color(0xffcacaca),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          color: Colors.deepPurple,
                          height: 60,
                          child: Image.network(
                            widget.contact.photoUrl,
                          ),
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
                        widget.contact.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          widget.contact.lastMessageIsMy ?? false
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
                            widget.contact.lastMessage ?? '',
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
                DateFormat.jm().format(widget.contact.lastEntry).toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
