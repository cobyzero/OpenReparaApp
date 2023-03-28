import 'package:flutter/material.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/controllers/loginController.dart';
import 'package:openrepara_app/models/UsersModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = TextEditingController();
  var password = TextEditingController();

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
                    controller: username,
                    texto: "Correo",
                    icon: Icons.person_2_outlined,
                    style: true,
                  ),
                  MyTextFormField(
                    controller: password,
                    oscure: true,
                    texto: "Contraseña",
                    icon: Icons.lock_outline,
                  ),
                  MyElevatedButton(
                    fun: () async {
                      cargando(context);
                      UsersModel usersModel =
                          await LoginController.checkLogin(username.text, password.text)
                              .whenComplete(() => Navigator.pop(context));

                      if (usersModel.id == 0) {
                        // ignore: use_build_context_synchronously
                        mensajeError(context, "Usuario o Contraseña invalidas");
                        return;
                      } else {
                        username.text = "";
                        password.text = "";
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, "home");
                      }
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
