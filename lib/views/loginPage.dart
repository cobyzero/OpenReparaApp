import 'package:flutter/material.dart';
import 'package:openrepara_app/common/common.dart';
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
        backgroundColor: mynegroprimary(),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "OpenRepair",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  space(h: 10),
                  /**
                   * Logo
                   */
                  Image.asset(
                    "assets/charlando.png",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  const Text(
                    "Welcome back!",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                  ),
                  const Text(
                    "Login in your account",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
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
                    w: 140,
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
