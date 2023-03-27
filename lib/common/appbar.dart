import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({super.key, required this.title});
  String title;
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
                )),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 2,
          color: Colors.grey,
        ),
      ],
    );
  }
}
