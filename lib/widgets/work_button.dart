import 'package:flutter/material.dart';

class WorkButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function()? onPressed;

  WorkButton({
    this.label,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        label ?? '',
        style: TextStyle(
          color: labelColor,
          fontSize: 20.0,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          side: borderColor != null
              ? BorderSide(color: borderColor ?? Color(0xFF000000))
              : BorderSide.none,
          borderRadius: BorderRadius.zero,
        ),
        padding: EdgeInsets.all(32.0),
      ),
      onPressed: onPressed,
    );
  }
}
