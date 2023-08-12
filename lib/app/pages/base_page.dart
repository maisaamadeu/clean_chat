import 'package:clean_chat/app/pages/home_page.dart';
import 'package:clean_chat/app/shared/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int index = 1;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAEAEA),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            Container(
              color: Colors.blue,
            ),
            HomePage(),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.yellow,
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.deepPurple,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
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
