import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  final String dateText;
  final String timeText;
  final String messageText;

  Clock({
    @required this.dateText,
    @required this.timeText,
    @required this.messageText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateText,
          style: TextStyle(
            fontSize: 40.0,
            letterSpacing: 4.0,
          ),
        ),
        Text(
          timeText,
          style: TextStyle(
            fontSize: 80.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 8.0,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          messageText,
          style: TextStyle(fontSize: 24.0),
        ),
      ],
    );
  }
}
