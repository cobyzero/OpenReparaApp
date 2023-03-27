import 'package:flutter/material.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png"),
                  const Text(
                    "OpenRepara",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  MyTextFormField(
                    texto: "Correo",
                    icon: Icons.person_2_outlined,
                    style: true,
                  ),
                  MyTextFormField(
                    texto: "Contraseña",
                    icon: Icons.lock_outline,
                  ),
                  MyElevatedButton(
                    fun: () {
                      Navigator.pushNamed(context, "home");
                    },
                    texto: "Iniciar Sesion",
                  ),
                  space(h: 10),
                  const MyCreditos()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
