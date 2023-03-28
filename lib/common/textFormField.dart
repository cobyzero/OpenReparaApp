import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  MyTextFormField(
      {super.key,
      required this.texto,
      this.icon,
      this.style = true,
      this.readOnly = false,
      this.oscure = false,
      this.controller});
  String texto;
  IconData? icon;
  bool style;
  bool readOnly;
  bool oscure;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: 300,
      height: 60,
      child: TextFormField(
        controller: controller,
        obscureText: oscure,
        readOnly: readOnly,
        decoration: InputDecoration(
            prefixIcon: style ? Icon(icon) : null,
            labelText: texto,
            border: style
                ? OutlineInputBorder(borderRadius: BorderRadius.circular(40))
                : const OutlineInputBorder()),
      ),
    );
  }
}
