import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final controller;

  MyTextField(
      {Key? key,
      required String this.label,
      required TextEditingController this.controller,
      required bool this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
      validator: null,
    );
  }
}

/*
 TextField(
      controller: controller,
      obscureText: true,
      decoration:
          InputDecoration(border: OutlineInputBorder(), labelText: label),
    )
*/