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
      margin: const EdgeInsets.only(top: 15, bottom: 15),
      width: 300,
      height: 60,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        obscureText: oscure,
        readOnly: readOnly,
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          prefixIconColor: Colors.white,
          fillColor: const Color(0xff1E1E1E),
          filled: true,
          prefixIcon: style ? Icon(icon) : null,
          labelText: texto,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: style
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(40))
              : const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
          border: style
              ? OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(40))
              : const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
        ),
      ),
    );
  }
}
