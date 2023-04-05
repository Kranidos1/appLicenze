import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key, required VoidCallback this.onPressed, required Text this.label, required Color this.backgroundColor, required Color this.foregroundColor}) : super(key: key);

  final VoidCallback onPressed;
  final Text label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      child: label,
    );
  }
}
