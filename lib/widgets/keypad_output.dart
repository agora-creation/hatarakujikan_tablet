import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class KeypadOutput extends StatelessWidget {
  final String recordPassword;

  KeypadOutput({required this.recordPassword});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black12,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              recordPassword == ''
                  ? Text('00000000', style: kKeypad2TextStyle)
                  : Text(recordPassword, style: kKeypadTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
