import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';

class TapListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? iconData;
  final Function()? onTap;

  TapListTile({
    this.title,
    this.subtitle,
    this.iconData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        title: Text(title ?? ''),
        subtitle: Text(subtitle ?? ''),
        trailing: onTap != null ? Icon(iconData) : null,
        onTap: onTap,
      ),
    );
  }
}
