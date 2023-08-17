import 'package:flutter/material.dart';

class CustomBottomAppbar extends StatelessWidget {
  const CustomBottomAppbar(
      {super.key, required this.index, required this.onPressed});

  final int index;
  final Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2.5,
            blurRadius: 20,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25),
          topLeft: Radius.circular(25),
        ),
        child: BottomAppBar(
          notchMargin: 5,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.chat_rounded,
                  color: index == 0 ? Colors.deepPurple : Color(0xffcacaca),
                ),
                iconSize: 30,
                onPressed: () => onPressed(0),
              ),
              const SizedBox(
                width: 1,
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: index == 1 ? Colors.deepPurple : Color(0xffcacaca),
                ),
                iconSize: 30,
                onPressed: () => onPressed(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
