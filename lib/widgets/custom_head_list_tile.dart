import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomHeadListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(
          'スタッフ一覧',
          style: TextStyle(color: Colors.black54),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
      ),
    );
  }
}
