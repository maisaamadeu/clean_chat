import 'package:clean_chat/app/data/mock/chats_data.dart';
import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> _contacts = [];

  @override
  void initState() {
    _contacts = ChatsData().getContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              //CONTACTS OPTIONS
              Row(
                children: [
                  //SEARCH MESSAGE
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.1,
                            blurRadius: 7.5,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: const Color(0xffcacaca),
                          ),
                          cursorColor: const Color(0xffcacaca),
                          decoration: const InputDecoration(
                            hintText: 'Procurar contatos...',
                            hintStyle: TextStyle(color: Color(0xffcacaca)),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              color: Color(0xffcacaca),
                              size: 30,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  //CONTACTS
                  Expanded(
                    child: Container(
                      height: 57,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.1,
                            blurRadius: 7.5,
                          )
                        ],
                      ),
                      child: IconButton.filled(
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.people_rounded,
                          size: 35,
                          color: Color(0xffcacaca),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),

              //CONTACTS LIST
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _contacts.length,
                  itemBuilder: (context, index) => Card(
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
                                backgroundColor: _contacts[index].isOnline
                                    ? Colors.green
                                    : const Color(0xffcacaca),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(1000),
                                  child: Container(
                                    color: Colors.deepPurple,
                                    height: 70,
                                    child: Image.asset(
                                      _contacts[index].avatarUrl,
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
                                    _contacts[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      _contacts[index].lastMessageIsMy
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                right: 5,
                                              ),
                                              child: const Icon(
                                                Icons.done_all_rounded,
                                                size: 15,
                                                color: Color.fromARGB(
                                                    255, 132, 132, 132),
                                              ),
                                            )
                                          : Container(),
                                      Text(
                                        _contacts[index].lastMessage,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 132, 132, 132),
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
                            DateFormat.jm()
                                .format(_contacts[index].lastEntry)
                                .toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
