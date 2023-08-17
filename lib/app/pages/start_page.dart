import 'package:clean_chat/app/data/services/firebase_service.dart';
import 'package:clean_chat/app/pages/base_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 165.0,
                          width: 165.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/black-woman.png'),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 165.0,
                          width: 165.0,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/old-man.png'),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.deepPurple.shade800,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 165.0,
                          width: 165.0,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage('assets/images/black-man.png'),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.deepPurple.shade800,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          height: 165.0,
                          width: 165.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/white-woman.png'),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 10,
                    )
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //TEXT
                    Column(
                      children: [
                        Text(
                          'Aproveite a nova experiência de conversar com seus amigos!',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Conecte-se com quem você mais ama de graça!',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    //SIGNIN/SIGNOUT BUTTON
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          User? user = await FirebaseService()
                              .signInWithGoogle(context: context);
                          if (user != null && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BasePage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/elements/google-logo.png',
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Começar',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //CREDITS
                    Text(
                      'Desenvolvido por Deheane',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
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
