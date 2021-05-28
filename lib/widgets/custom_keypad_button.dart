import 'package:flutter/material.dart';

class CustomKeypadButton extends StatelessWidget {
  final String labelText;
  final Color backgroundColor;
  final Function onPressed;

  CustomKeypadButton({
    this.labelText,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        labelText,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 32.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
