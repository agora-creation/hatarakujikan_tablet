import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/clock.dart';
import 'package:hatarakujikan_tablet/widgets/work_buttons.dart';

class HomeLeft extends StatefulWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  HomeLeft({
    required this.groupProvider,
    required this.workProvider,
  });

  @override
  State<HomeLeft> createState() => _HomeLeftState();
}

class _HomeLeftState extends State<HomeLeft> {
  String? date;
  String? time;

  void _onTimer(Timer timer) {
    DateTime _now = DateTime.now();
    if (mounted) {
      setState(() {
        date = dateText('yyyy/MM/dd (E)', _now);
        time = dateText('HH:mm:ss', _now);
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
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Clock(
            date: date,
            time: time,
            user: widget.groupProvider.currentUser,
          ),
          WorkButtons(
            user: widget.groupProvider.currentUser,
            workStartOnPressed: () {},
            workEndOnPressed: () {},
            breakStartOnPressed: () {},
            breakEndOnPressed: () {},
          ),
        ],
      ),
    );
  }
}

class WorkStartDialog extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  WorkStartDialog({
    required this.groupProvider,
    required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.run_circle,
              color: Colors.blue,
              size: 64.0,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            '出勤時間を記録します。よろしいですか？',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.grey,
                label: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workStart(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.currentUserReload();
                  Navigator.pop(context);
                },
                color: Colors.blue,
                label: 'はい',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
