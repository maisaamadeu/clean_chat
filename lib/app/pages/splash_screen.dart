// ignore_for_file: use_build_context_synchronously

import 'package:clean_chat/app/data/repositories/firebase_repository.dart';
import 'package:clean_chat/app/pages/base_page.dart';
import 'package:clean_chat/app/pages/start_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    verifyAccount();
    super.initState();
  }

  void verifyAccount() async {
    await FirebaseRepository().initFirebase();
    User? currentUser = await FirebaseRepository().getCurrentUser();

    if (context.mounted) {
      if (currentUser == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const StartPage(),
          ),
        );
      } else {
        await FirebaseRepository().updateDataUser(currentUser);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BasePage(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFEAEAEA),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_rounded,
                color: Colors.deepPurple,
                size: 96,
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
