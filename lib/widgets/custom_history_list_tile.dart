import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/work.dart';

class CustomHistoryListTile extends StatelessWidget {
  final WorkModel? work;

  CustomHistoryListTile({this.work});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(
          dateText('dd (E)', work!.startedAt),
          style: TextStyle(color: Colors.black45),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              dateText('HH:mm', work!.startedAt),
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
            work!.startedAt != work!.endedAt
                ? Text(
                    dateText('HH:mm', work!.endedAt),
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  )
                : Text(
                    '---:---',
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  ),
            work!.startedAt != work!.endedAt
                ? Text(
                    work!.workTime(),
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  )
                : Text(
                    '---:---',
                    style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  ),
          ],
        ),
      ),
    );
  }
}
