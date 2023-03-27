import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({super.key, required this.fun, required this.texto});
  Function() fun;
  String texto;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(fixedSize: const Size(200, 40), shape: const StadiumBorder()),
      child: Text(texto),
    );
  }
}
