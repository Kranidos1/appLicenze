import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscure;
  final controller;
  final bool readOnly;

  const MyTextField({Key? key, required this.label, required TextEditingController this.controller, required this.obscure ,required this.readOnly}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(border: const OutlineInputBorder(), labelText: label),
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