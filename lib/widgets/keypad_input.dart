import 'package:flutter/material.dart';

class KeypadInput extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final Function()? onPressed;

  KeypadInput({
    this.label,
    this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        child: Text(
          label ?? '',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 32.0,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black12, width: 0.5),
            borderRadius: BorderRadius.zero,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
