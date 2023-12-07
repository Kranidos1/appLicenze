import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/loginForm.dart';
import './socket/socket.dart';
import './LicenzeFEScreen.dart';
import '../widgets/statefullWrapper.dart';

class LoginScreen extends StatefulWidget {
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  late SocketService socket;

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();

    widget.socket = SocketService();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 45),
        child: Column(
          children: [
            Image.asset("contents/images/logo.png"),
            LoginForm(
                usernameTextController: widget.usernameTextController,
                passwordTextController: widget.passwordTextController,
                onPressed: () async {
                  String username = widget.usernameTextController.text;

                  final check = await widget.socket
                      .login(username, widget.passwordTextController.text);

                  if (check == 1) {
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LicenzeFEScreen(
                        username: username,
                        socket: widget.socket,
                      );
                    }), (Route<dynamic> route) => false);
                  } else if (check == 3) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Abilitare la connessione internet."),
                              icon: Icon(Icons.warning_outlined),
                            ));
                  } else if (check == 2) {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Impossibile raggiungere l'host."),
                              icon: Icon(Icons.warning_outlined),
                            ));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                              title: Text("Dati inseriti errati."),
                              icon: Icon(Icons.warning_outlined),
                            ));
                  }
                }),
            Wrapper(
              context: context,
            )
          ],
        ),
      )),
    );
  }

  @override
  void dispose() {
    dispose();
    widget.usernameTextController.dispose();
    widget.passwordTextController.dispose();
  }
}
