import 'package:flutter/material.dart';

class CustomWorkBorderButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function() onPressed;

  CustomWorkBorderButton({
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
          color: color,
          fontSize: 20.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Color(0xFFFEFFFA),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color, width: 1),
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.all(32.0),
      ),
    );
  }
}
