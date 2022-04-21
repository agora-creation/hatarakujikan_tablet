import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/clock.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';
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
            workStartOnPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => WorkStartDialog(
                  groupProvider: widget.groupProvider,
                  workProvider: widget.workProvider,
                ),
              );
            },
            workEndOnPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => WorkEndDialog(
                  groupProvider: widget.groupProvider,
                  workProvider: widget.workProvider,
                ),
              );
            },
            breakStartOnPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => BreakStartDialog(
                  groupProvider: widget.groupProvider,
                  workProvider: widget.workProvider,
                ),
              );
            },
            breakEndOnPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => BreakEndDialog(
                  groupProvider: widget.groupProvider,
                  workProvider: widget.workProvider,
                ),
              );
            },
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
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  if (!await workProvider.workStart(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WorkEndDialog extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  WorkEndDialog({
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
              color: Colors.red,
              size: 64.0,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            '退勤時間を記録します。よろしいですか？',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  if (!await workProvider.workEnd(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BreakStartDialog extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  BreakStartDialog({
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
              color: Colors.orange,
              size: 64.0,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            '休憩開始時間を記録します。よろしいですか？',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  if (!await workProvider.breakStart(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BreakEndDialog extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  BreakEndDialog({
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
              Icons.run_circle_outlined,
              color: Colors.orange,
              size: 64.0,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            '休憩終了時間を記録します。よろしいですか？',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  if (!await workProvider.breakEnd(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
