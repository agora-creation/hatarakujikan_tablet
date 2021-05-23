import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';

class CustomUserListTile extends StatelessWidget {
  final UserModel user;
  final bool selected;
  final Function onTap;

  CustomUserListTile({
    this.user,
    this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        tileColor: selected ? Colors.teal.shade200 : Color(0xFFFEFFFA),
        title: Text(
          user.name,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24.0,
          ),
        ),
        trailing: user.workLv == 1
            ? Chip(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.all(8.0),
                label: Text(
                  '出勤中',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )
            : user.workLv == 2
                ? Chip(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.all(8.0),
                    label: Text(
                      '休憩中',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  )
                : null,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        onTap: onTap,
      ),
    );
  }
}
