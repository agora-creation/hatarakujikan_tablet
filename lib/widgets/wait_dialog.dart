import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class WaitDialog extends StatelessWidget {
  final String? message;

  WaitDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.0),
          Loading(color: Colors.blue),
          SizedBox(height: 24.0),
          Text(
            message ?? '',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
