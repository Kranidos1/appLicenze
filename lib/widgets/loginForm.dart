import 'package:flutter/material.dart';
import './button.dart';
import './textField.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(
      {Key? key,
      required this.usernameTextController,
      required this.passwordTextController,
      required this.onPressed})
      : super(key: key);

  final TextEditingController usernameTextController;
  final TextEditingController passwordTextController;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
          child: MyTextField(
            readOnly: false,
            label: "Username",
            controller: usernameTextController,
            obscure: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: MyTextField(
            readOnly: false,
            label: "Password",
            controller: passwordTextController,
            obscure: true,
          ),
        ),
        MyButton(
          onPressed: onPressed,
          label: const Text("Login"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        )
      ],
    );
  }
}
