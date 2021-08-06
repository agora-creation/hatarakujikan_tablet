import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_header_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_keypad_button.dart';
import 'package:hatarakujikan_tablet/widgets/error_dialog.dart';

class Keypad extends StatefulWidget {
  final GroupProvider groupProvider;

  Keypad({@required this.groupProvider});

  @override
  _KeypadState createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String recordPassword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeaderListTile(
          iconData: Icons.dialpad,
          label: '暗証番号を入力してください',
        ),
        Expanded(
          child: Container(
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  recordPassword != ''
                      ? Text(
                          recordPassword,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8.0,
                          ),
                        )
                      : Text(
                          '00000000',
                          style: TextStyle(
                            color: Colors.black26,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 8.0,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '7');
                      }
                    },
                    label: '7',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '8');
                      }
                    },
                    label: '8',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '9');
                      }
                    },
                    label: '9',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '4');
                      }
                    },
                    label: '4',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '5');
                      }
                    },
                    label: '5',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '6');
                      }
                    },
                    label: '6',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '1');
                      }
                    },
                    label: '1',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '2');
                      }
                    },
                    label: '2',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '3');
                      }
                    },
                    label: '3',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      setState(() => recordPassword = '');
                    },
                    label: '訂正',
                    color: Color(0xFFFFCDD2),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (recordPassword.length < 8) {
                        setState(() => recordPassword += '0');
                      }
                    },
                    label: '0',
                    color: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () async {
                      if (recordPassword == '') {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => ErrorDialog('暗証番号を入力してください。'),
                        );
                        return;
                      }
                      if (!await widget.groupProvider.currentUserChange(
                        recordPassword: recordPassword,
                      )) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => ErrorDialog('入力した暗証番号が間違っています。'),
                        );
                        return;
                      }
                      setState(() => recordPassword = '');
                    },
                    label: '確定',
                    color: Color(0xFFBBDEFB),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
