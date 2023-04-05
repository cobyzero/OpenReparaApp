import 'package:flutter/material.dart';
import 'package:openrepara_app/common/common.dart';
import 'package:openrepara_app/common/creditos.dart';
import 'package:openrepara_app/common/elevatedButton.dart';
import 'package:openrepara_app/common/localData.dart';
import 'package:openrepara_app/common/textFormField.dart';
import 'package:openrepara_app/viewModel/userViewModel.dart';

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
                  /**
                   * Logo
                   */
                  Image.asset("assets/logo.png"),
                  /**
                   * Text [Title]
                   */
                  const Text(
                    "OpenRepair",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  /**
                   * Form [Username]
                   */
                  MyTextFormField(
                    controller: username,
                    texto: "Username",
                    icon: Icons.person_2_outlined,
                    style: true,
                  ),
                  /**
                   * Form [Password]
                   */
                  MyTextFormField(
                    controller: password,
                    oscure: true,
                    texto: "Password",
                    icon: Icons.lock_outline,
                  ),
                  /**
                   * Button [Login]
                   */
                  MyElevatedButton(
                    fun: () async {
                      cargando(context);

                      await listUserViewModel
                          .checkLogin(username.text, password.text)
                          .whenComplete(() => Navigator.pop(context));

                      if (listUserViewModel.list![0].usersModel.id == 0) {
                        // ignore: use_build_context_synchronously
                        mensajeError(context, "Username or password are invalid");
                        return;
                      } else {
                        username.text = "";
                        password.text = "";
                        LocalData.userViewModel = listUserViewModel.list![0];
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, "home");
                      }
                    },
                    texto: "Login",
                  ),
                  space(h: 10),
                  /**
                   * Credits by Cobyzero
                   */
                  const MyCredits()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  var username = TextEditingController();
  var password = TextEditingController();
  ListUserViewModel listUserViewModel = ListUserViewModel();
}
