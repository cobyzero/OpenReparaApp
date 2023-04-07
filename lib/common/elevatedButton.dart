import 'package:flutter/material.dart';
import 'package:openrepara_app/common/common.dart';

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({super.key, required this.fun, required this.texto, this.w = 200});
  Function() fun;
  String texto;
  double w;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(w, 40), shape: const StadiumBorder(), backgroundColor: myprimarycolor()),
      child: Text(texto),
    );
  }
}
