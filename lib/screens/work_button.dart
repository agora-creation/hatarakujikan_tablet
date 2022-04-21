import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_work_background_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_work_border_list_tile.dart';

class WorkButton extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  WorkButton({
    required this.groupProvider,
    required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    return groupProvider.currentUser != null
        ? Container(
            child: Row(
              children: [
                Expanded(
                  child: groupProvider.currentUser?.workLv == 0
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => WorkStartDialog(
                                groupProvider: groupProvider,
                                workProvider: workProvider,
                              ),
                            );
                          },
                          label: '出勤',
                          backgroundColor: Colors.blue,
                        )
                      : CustomWorkBackgroundButton(
                          onPressed: null,
                          label: '出勤',
                          backgroundColor: Colors.grey,
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 1
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => WorkEndDialog(
                                groupProvider: groupProvider,
                                workProvider: workProvider,
                              ),
                            );
                          },
                          label: '退勤',
                          backgroundColor: Colors.red,
                        )
                      : CustomWorkBackgroundButton(
                          onPressed: null,
                          label: '退勤',
                          backgroundColor: Colors.grey,
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 1
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => BreakStartDialog(
                                groupProvider: groupProvider,
                                workProvider: workProvider,
                              ),
                            );
                          },
                          label: '休憩開始',
                          backgroundColor: Colors.orange,
                        )
                      : CustomWorkBackgroundButton(
                          onPressed: null,
                          label: '休憩開始',
                          backgroundColor: Colors.grey,
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 2
                      ? CustomWorkBorderButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => BreakEndDialog(
                                groupProvider: groupProvider,
                                workProvider: workProvider,
                              ),
                            );
                          },
                          label: '休憩終了',
                          color: Colors.orange,
                        )
                      : CustomWorkBackgroundButton(
                          onPressed: null,
                          label: '休憩終了',
                          backgroundColor: Colors.grey,
                        ),
                ),
              ],
            ),
          )
        : Container();
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
                onPressed: () => Navigator.pop(context),
                color: Colors.grey,
                label: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workEnd(
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
                onPressed: () => Navigator.pop(context),
                color: Colors.grey,
                label: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakStart(
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
                onPressed: () => Navigator.pop(context),
                color: Colors.grey,
                label: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakEnd(
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
