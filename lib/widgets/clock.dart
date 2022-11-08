import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';

class Clock extends StatelessWidget {
  final UserModel? user;
  final String? date;
  final String? time;

  Clock({
    this.user,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.teal.shade100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(date ?? '----/--/-- (-)', style: kDateTextStyle),
            Text(time ?? '--:--:--', style: kTimeTextStyle),
            SizedBox(height: 16.0),
            user == null
                ? Text(
                    '右のテンキーで、あなたの暗証番号を入力してください',
                    style: kHomeTextStyle,
                  )
                : Column(
                    children: [
                      Text(
                        'おはようございます、${user?.name ?? ''}さん',
                        style: kHomeTextStyle,
                      ),
                      Text(
                        '下のボタンから選んで押してください',
                        style: kHomeTextStyle,
                      ),
                      user?.autoWorkEnd == true
                          ? SizedBox(height: 16)
                          : Container(),
                      user?.autoWorkEnd == true
                          ? Text(
                              '※自動退勤が設定されています。出勤ボタンを押すと同時に「${user?.autoWorkEndTime ?? '00:00'}」に退勤したことになります。',
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
