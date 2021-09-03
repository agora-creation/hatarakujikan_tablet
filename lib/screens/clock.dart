import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  final GroupProvider groupProvider;

  Clock({@required this.groupProvider});

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
    UserModel _user = widget.groupProvider.currentUser;

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
          _user == null
              ? '右のテンキーから暗証番号を入力してください'
              : 'おはようございます、${_user?.name}さん',
          style: TextStyle(fontSize: 26.0),
        ),
        _user != null
            ? Text(
                '下のボタンから選んで押してください',
                style: TextStyle(fontSize: 26.0),
              )
            : Container(),
      ],
    );
  }
}
