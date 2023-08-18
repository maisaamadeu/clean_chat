import 'package:clean_chat/app/data/blocs/firebase_bloc.dart';
import 'package:clean_chat/app/data/blocs/firebase_event.dart';
import 'package:clean_chat/app/data/blocs/firebase_state.dart';
import 'package:clean_chat/app/data/models/contact_model.dart';
import 'package:clean_chat/app/data/repositories/firebase_repository.dart';
import 'package:clean_chat/app/shared/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FirebaseBloc _firebaseBloc;
  late final FirebaseRepository _firebaseRepository;

  @override
  void initState() {
    super.initState();
    _firebaseBloc = FirebaseBloc();
    _firebaseBloc.add(GetContacts());
    _firebaseRepository = FirebaseRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: StreamBuilder(
        stream: _firebaseRepository.getContactsStream(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Ocorreu um erro, tente novamente mais tarde!'),
                );
              } else {
                final List<ContactModel?>? contacts = snapshot.data;
                return SingleChildScrollView(
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
                                      hintStyle:
                                          TextStyle(color: Color(0xffcacaca)),
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
                            itemCount: contacts == null ? 0 : contacts.length,
                            itemBuilder: (context, index) =>
                                ContactCard(contact: contacts![index]!),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
