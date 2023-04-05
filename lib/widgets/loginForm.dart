import 'package:flutter/material.dart';
import './button.dart';
import './textField.dart';

class LoginForm extends StatelessWidget {
  const LoginForm(
      {Key? key,
      required TextEditingController this.usernameTextController,
      required TextEditingController this.passwordTextController,
      required VoidCallback this.onPressed})
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
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
          child: MyTextField(
            label: "Username",
            controller: usernameTextController,
            obscure: false,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: MyTextField(
            label: "Password",
            controller: passwordTextController,
            obscure: true,
          ),
        ),
        MyButton(
          onPressed: onPressed,
          label: Text("Login"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        )
      ],
    );
  }
}
