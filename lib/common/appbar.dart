import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({super.key, required this.title, this.home = false});
  String title;
  bool home;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                )),
            Text(
              title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}
