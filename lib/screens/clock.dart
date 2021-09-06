import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final UserModel user;

  Clock({@required this.user});

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String dateText = '----/--/-- (-)';
  String timeText = '--:--:--';

  void _onTimer(Timer timer) {
    var _now = DateTime.now();
    var _dateFormat = DateFormat('yyyy/MM/dd (E)', 'ja');
    var _timeFormat = DateFormat('HH:mm:ss');
    var _dateText = _dateFormat.format(_now);
    var _timeText = _timeFormat.format(_now);
    if (mounted) {
      setState(() {
        dateText = _dateText;
        timeText = _timeText;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          dateText,
          style: kDateTextStyle,
        ),
        Text(
          timeText,
          style: kTimeTextStyle,
        ),
        SizedBox(height: 16.0),
        Text(
          widget.user == null
              ? '右のテンキーから暗証番号を入力してください'
              : 'おはようございます、${widget.user?.name}さん',
          style: TextStyle(fontSize: 26.0),
        ),
        widget.user != null
            ? Text(
                '下のボタンから選んで押してください',
                style: TextStyle(fontSize: 26.0),
              )
            : Container(),
      ],
    );
  }
}
