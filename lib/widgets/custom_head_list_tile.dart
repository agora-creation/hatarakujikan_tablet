import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomHeadListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text('日付', style: TextStyle(color: Colors.black45)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('出勤', style: TextStyle(color: Colors.black45, fontSize: 16.0)),
            Text('退勤', style: TextStyle(color: Colors.black45, fontSize: 16.0)),
            Text('勤務', style: TextStyle(color: Colors.black45, fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}
