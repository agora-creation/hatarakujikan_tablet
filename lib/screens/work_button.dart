import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';

class WorkButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kWorkButtonDecoration,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WorkStartDialog(),
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
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => WorkEndDialog(),
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
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => BreakStartDialog(),
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
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => BreakEndDialog(),
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
            ),
          ),
        ],
      ),
    );
  }
}

class WorkStartDialog extends StatelessWidget {
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
                onPressed: () => Navigator.pop(context),
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
                onPressed: () => Navigator.pop(context),
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
                onPressed: () => Navigator.pop(context),
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
                onPressed: () => Navigator.pop(context),
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
