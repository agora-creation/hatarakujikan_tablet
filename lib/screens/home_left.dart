import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/clock.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';
import 'package:hatarakujikan_tablet/widgets/error_dialog.dart';
import 'package:hatarakujikan_tablet/widgets/wait_dialog.dart';
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
              widget.groupProvider.countStop();
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
              widget.groupProvider.countStop();
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
              widget.groupProvider.countStop();
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
              widget.groupProvider.countStop();
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
                onPressed: () async {
                  Navigator.pop(context);
                  await Future.delayed(Duration(seconds: 1));
                  groupProvider.countStart();
                },
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WaitDialog('記録中です。しばらくお待ちください。'),
                  );
                  if (!await workProvider.workStart(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    Navigator.pop(context);
                    await Future.delayed(Duration(seconds: 1));
                    groupProvider.countStart();
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => ErrorDialog('出勤時間の記録に失敗しました。'),
                    );
                    return;
                  } else {
                    groupProvider.reloadUser();
                    Navigator.pop(context);
                    await Future.delayed(Duration(seconds: 1));
                    groupProvider.countStart();
                  }
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
                onPressed: () {
                  groupProvider.countStart();
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  groupProvider.countStart();
                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WaitDialog('記録中です。しばらくお待ちください。'),
                  );
                  groupProvider.countStop();
                  if (!await workProvider.workEnd(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    Navigator.pop(context);
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => ErrorDialog('退勤時間の記録に失敗しました。'),
                    );
                    return;
                  } else {
                    groupProvider.reloadUser();
                    groupProvider.countStart();
                    Navigator.pop(context);
                  }
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
                onPressed: () {
                  groupProvider.countStart();
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  groupProvider.countStart();
                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WaitDialog('記録中です。しばらくお待ちください。'),
                  );
                  groupProvider.countStop();
                  if (!await workProvider.breakStart(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    Navigator.pop(context);
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => ErrorDialog('休憩開始時間の記録に失敗しました。'),
                    );
                    return;
                  } else {
                    groupProvider.reloadUser();
                    groupProvider.countStart();
                    Navigator.pop(context);
                  }
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
                onPressed: () {
                  groupProvider.countStart();
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  groupProvider.countStart();
                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => WaitDialog('記録中です。しばらくお待ちください。'),
                  );
                  groupProvider.countStop();
                  if (!await workProvider.breakEnd(
                    group: groupProvider.group,
                    user: groupProvider.currentUser,
                  )) {
                    Navigator.pop(context);
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => ErrorDialog('休憩開始時間の記録に失敗しました。'),
                    );
                    return;
                  } else {
                    groupProvider.reloadUser();
                    groupProvider.countStart();
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
