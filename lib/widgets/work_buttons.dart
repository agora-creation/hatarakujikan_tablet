import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/widgets/work_button.dart';

class WorkButtons extends StatelessWidget {
  final UserModel? user;
  final Function()? workStartOnPressed;
  final Function()? workEndOnPressed;
  final Function()? breakStartOnPressed;
  final Function()? breakEndOnPressed;

  WorkButtons({
    this.user,
    this.workStartOnPressed,
    this.workEndOnPressed,
    this.breakStartOnPressed,
    this.breakEndOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal.shade100,
      padding: EdgeInsets.all(40),
      child: user != null
          ? Container(
              decoration: kWorkButtonDecoration,
              child: Row(
                children: [
                  Expanded(
                    child: WorkButton(
                      label: '出勤',
                      labelColor: Color(0xFFFEFFFA),
                      backgroundColor:
                          user?.workLv == 0 ? Colors.blue : Colors.grey,
                      onPressed: user?.workLv == 0 ? workStartOnPressed : null,
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Expanded(
                    child: WorkButton(
                      label: '退勤',
                      labelColor: Color(0xFFFEFFFA),
                      backgroundColor:
                          user?.workLv == 1 ? Colors.red : Colors.grey,
                      onPressed: user?.workLv == 1 ? workEndOnPressed : null,
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Expanded(
                    child: WorkButton(
                      label: '休憩開始',
                      labelColor: Color(0xFFFEFFFA),
                      backgroundColor:
                          user?.workLv == 1 ? Colors.orange : Colors.grey,
                      onPressed: user?.workLv == 1 ? breakStartOnPressed : null,
                    ),
                  ),
                  SizedBox(width: 1.0),
                  Expanded(
                    child: WorkButton(
                      label: '休憩終了',
                      labelColor:
                          user?.workLv == 2 ? Colors.orange : Color(0xFFFEFFFA),
                      backgroundColor:
                          user?.workLv == 2 ? Color(0xFFFEFFFA) : Colors.grey,
                      borderColor: user?.workLv == 2 ? Colors.orange : null,
                      onPressed: user?.workLv == 2 ? breakStartOnPressed : null,
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }
}
