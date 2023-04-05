import 'package:flutter/material.dart';
import './screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {},
      title: "ProgettoLSO",
      theme: ThemeData(primarySwatch: Colors.grey),
      home: LoginScreen(),
    );
  }
}
