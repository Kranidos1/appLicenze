import 'package:flutter/material.dart';
import '../widgets/loginForm.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: [
            Icon(Icons.star),
            LoginForm(
                usernameTextController: usernameTextController,
                passwordTextController: passwordTextController,
                onPressed: () {
                  print("ok");
                })
          ],
        ),
      )),
    );
  }
}
