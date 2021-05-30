import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomFooterListTile extends StatelessWidget {
  final Function onTap;

  CustomFooterListTile({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTopBorderDecoration,
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.arrow_back, size: 24.0),
        title: Text(
          '入力に戻る',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 24.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      ),
    );
  }
}
