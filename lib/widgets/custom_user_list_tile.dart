import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomUserListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(
          'テスト太郎',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
          ),
        ),
        trailing: Chip(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.all(8.0),
          label: Text(
            '出勤中',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        onTap: () {},
      ),
    );
  }
}
