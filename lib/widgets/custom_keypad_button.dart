import 'package:flutter/material.dart';

class CustomKeypadButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function onPressed;

  CustomKeypadButton({
    this.label,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.black54,
          fontSize: 32.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}
