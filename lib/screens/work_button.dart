import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';

class WorkButton extends StatelessWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  WorkButton({
    @required this.groupProvider,
    @required this.workProvider,
  });

  @override
  Widget build(BuildContext context) {
    return groupProvider.currentUser != null
        ? Container(
            decoration: kWorkButtonDecoration,
            child: Row(
              children: [
                Expanded(
                  child: groupProvider.currentUser?.workLv == 0
                      ? TextButton(
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
                          child: Text(
                            '出勤',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        )
                      : TextButton(
                          onPressed: null,
                          child: Text(
                            '出勤',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 1
                      ? TextButton(
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
                          child: Text(
                            '退勤',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        )
                      : TextButton(
                          onPressed: null,
                          child: Text(
                            '退勤',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 1
                      ? TextButton(
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
                          child: Text(
                            '休憩開始',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        )
                      : TextButton(
                          onPressed: null,
                          child: Text(
                            '休憩開始',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        ),
                ),
                SizedBox(width: 1.0),
                Expanded(
                  child: groupProvider.currentUser?.workLv == 2
                      ? TextButton(
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
                          child: Text(
                            '休憩終了',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFFFEFFFA),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.orange, width: 1),
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
                        )
                      : TextButton(
                          onPressed: null,
                          child: Text(
                            '休憩終了',
                            style: TextStyle(
                              color: Color(0xFFFEFFFA),
                              fontSize: 24.0,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            padding: EdgeInsets.all(32.0),
                          ),
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
    @required this.groupProvider,
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
                backgroundColor: Colors.grey,
                labelText: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workStart(
                    groupId: groupProvider.group?.id,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                labelText: 'はい',
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
    @required this.groupProvider,
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
                backgroundColor: Colors.grey,
                labelText: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.workEnd(
                    groupId: groupProvider.group?.id,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                labelText: 'はい',
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
    @required this.groupProvider,
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
                backgroundColor: Colors.grey,
                labelText: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakStart(
                    groupId: groupProvider.group?.id,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                labelText: 'はい',
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
    @required this.groupProvider,
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
                backgroundColor: Colors.grey,
                labelText: 'キャンセル',
              ),
              CustomTextButton(
                onPressed: () async {
                  if (!await workProvider.breakEnd(
                    groupId: groupProvider.group?.id,
                    user: groupProvider.currentUser,
                  )) {
                    return;
                  }
                  groupProvider.reloadUser();
                  Navigator.pop(context);
                },
                backgroundColor: Colors.blue,
                labelText: 'はい',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
