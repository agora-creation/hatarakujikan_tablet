import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class HistoryFooter extends StatelessWidget {
  final int currentSeconds;
  final Function()? onTap;

  HistoryFooter({
    required this.currentSeconds,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTopBorderDecoration,
      child: ListTile(
        leading: Icon(Icons.arrow_back, size: 24.0),
        title: Text(
          '$currentSeconds秒後、入力に戻る',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        onTap: onTap,
      ),
    );
  }
}
