import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class CustomHeaderListTile extends StatelessWidget {
  final IconData? iconData;
  final String? label;

  CustomHeaderListTile({
    this.iconData,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Row(
          children: [
            Icon(iconData, color: Colors.black54),
            SizedBox(width: 16.0),
            Text(label ?? '', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
