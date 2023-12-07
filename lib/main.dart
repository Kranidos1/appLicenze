import 'package:app_licenze/screens/LoginScreen.dart';
import 'package:app_licenze/screens/StoricoScreen.dart';
import 'package:app_licenze/screens/socket/socket.dart';
import 'package:flutter/material.dart';
import './screens/LicenzeFEScreen.dart';
import './screens/LicenzeScreen.dart';
import 'dart:async';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: const {},
        title: "appLicenze",
        theme: ThemeData(primarySwatch: Colors.grey),
        home: //LoginScreen(),
            LicenzeFEScreen(username: "mattia", socket: SocketService()));
  }
}
