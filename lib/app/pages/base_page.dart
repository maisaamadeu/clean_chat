import 'package:clean_chat/app/data/services/firebase_service.dart';
import 'package:clean_chat/app/pages/home_page.dart';
import 'package:clean_chat/app/pages/start_page.dart';
import 'package:clean_chat/app/pages/user_page.dart';
import 'package:clean_chat/app/shared/widgets/custom_bottom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int index = 0;
  final PageController _pageController = PageController(initialPage: 0);
  // final TextEditingController _textEditingController = TextEditingController();

  User? user;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    user = await FirebaseService().getCurrentUser();

    if (user == null && context.mounted) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const StartPage(),
          ),
          (route) => false);
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            const HomePage(),
            UserPage(user: user!),
          ],
        ),
      ),
      floatingActionButton: index == 0
          ? SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        backgroundColor: const Color(0xFFEAEAEA),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Adicionar amigo',
                                style: GoogleFonts.inter(
                                  color: Colors.deepPurple,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ClipRRect(
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
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.deepPurple,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
          CustomBottomAppbar(index: index, onPressed: setIndex),
    );
  }

  setIndex(int newIndex) {
    setState(
      () {
        if (newIndex < 4) {
          index = newIndex;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        }
      },
    );
  }
}
