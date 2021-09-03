import 'package:flutter/material.dart';

class CustomWorkBackgroundButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Function() onPressed;

  CustomWorkBackgroundButton({
    this.label,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xFFFEFFFA),
          fontSize: 20.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.all(32.0),
      ),
    );
  }
}
