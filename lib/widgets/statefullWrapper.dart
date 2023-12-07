import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../screens/socket/socket.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key, required this.context}) : super(key: key);
  final context;
  _WrapperState createState() => _WrapperState();
  Timer? timer;
}

class _WrapperState extends State<Wrapper> {
  SocketService socket = SocketService();
  bool dismissible = false;

  @override
  void initState() {
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            print("connected");
            dismissible = true;
            break;
          case InternetConnectionStatus.disconnected:
            Timer.periodic(Duration(seconds: 5), (Timer t) {
              exit(0);
            });
            showDialog(
                barrierDismissible: dismissible,
                context: context,
                builder: (contextM) {
                  return AlertDialog(
                    title: Text("Abilitare la connessione e riavviare l'app."),
                    icon: Icon(Icons.warning_outlined),
                  );
                });
            break;
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
