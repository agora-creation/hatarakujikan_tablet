import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/work.dart';

class HistoryList extends StatelessWidget {
  final WorkModel work;

  HistoryList({required this.work});

  @override
  Widget build(BuildContext context) {
    String day = dateText('dd (E)', work.startedAt);
    String startTime = dateText('HH:mm', work.startedAt);
    String endTime = '---:---';
    String workTime = '---:---';
    if (work.startedAt != work.endedAt) {
      endTime = dateText('HH:mm', work.endedAt);
      workTime = work.workTime();
    }
    return Container(
      decoration: kBottomBorderDecoration,
      child: ListTile(
        leading: Text(day, style: TextStyle(color: Colors.black45)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              startTime,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
            Text(
              endTime,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
            Text(
              workTime,
              style: TextStyle(color: Colors.black54, fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
