import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomFooterListTile extends StatelessWidget {
  final String labelText;
  final Function onTap;

  CustomFooterListTile({
    this.labelText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kTopBorderDecoration,
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.arrow_back, size: 24.0),
        title: Text(
          labelText,
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