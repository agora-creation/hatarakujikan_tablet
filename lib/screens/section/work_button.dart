import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/section.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_work_background_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_work_border_list_tile.dart';

class SectionWorkButton extends StatelessWidget {
  final SectionProvider sectionProvider;
  final WorkProvider workProvider;

  SectionWorkButton({
    @required this.sectionProvider,
    @required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    return sectionProvider.currentUser != null
        ? Container(
            decoration: kWorkButtonDecoration,
            child: Row(
              children: [
                Expanded(
                  child: sectionProvider.currentUser?.workLv == 0
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => WorkStartDialog(
                                sectionProvider: sectionProvider,
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
                  child: sectionProvider.currentUser?.workLv == 1
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => WorkEndDialog(
                                sectionProvider: sectionProvider,
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
                  child: sectionProvider.currentUser?.workLv == 1
                      ? CustomWorkBackgroundButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => BreakStartDialog(
                                sectionProvider: sectionProvider,
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
                  child: sectionProvider.currentUser?.workLv == 2
                      ? CustomWorkBorderButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => BreakEndDialog(
                                sectionProvider: sectionProvider,
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
  final SectionProvider sectionProvider;
  final WorkProvider workProvider;

  WorkStartDialog({
    @required this.sectionProvider,
    @required this.workProvider,
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
                    groupId: sectionProvider.group?.id,
                    user: sectionProvider.currentUser,
                  )) {
                    return;
                  }
                  sectionProvider.reloadUsers();
                  sectionProvider.currentUserReload();
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
  final SectionProvider sectionProvider;
  final WorkProvider workProvider;

  WorkEndDialog({
    @required this.sectionProvider,
    @required this.workProvider,
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
                    groupId: sectionProvider.group?.id,
                    user: sectionProvider.currentUser,
                  )) {
                    return;
                  }
                  sectionProvider.reloadUsers();
                  sectionProvider.currentUserReload();
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
  final SectionProvider sectionProvider;
  final WorkProvider workProvider;

  BreakStartDialog({
    @required this.sectionProvider,
    @required this.workProvider,
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
                    groupId: sectionProvider.group?.id,
                    user: sectionProvider.currentUser,
                  )) {
                    return;
                  }
                  sectionProvider.reloadUsers();
                  sectionProvider.currentUserReload();
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
  final SectionProvider sectionProvider;
  final WorkProvider workProvider;

  BreakEndDialog({
    @required this.sectionProvider,
    @required this.workProvider,
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
                    groupId: sectionProvider.group?.id,
                    user: sectionProvider.currentUser,
                  )) {
                    return;
                  }
                  sectionProvider.reloadUsers();
                  sectionProvider.currentUserReload();
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
