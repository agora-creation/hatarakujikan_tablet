import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_header_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_keypad_button.dart';
import 'package:hatarakujikan_tablet/widgets/error_message.dart';

class Keypad extends StatefulWidget {
  final GroupProvider groupProvider;

  Keypad({@required this.groupProvider});

  @override
  _KeypadState createState() => _KeypadState();
}

class _KeypadState extends State<Keypad> {
  String workPassword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeaderListTile(
          iconData: Icons.dialpad,
          labelText: '暗証番号を入力してください',
        ),
        Expanded(
          child: Container(
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  workPassword != ''
                      ? Text(
                          workPassword,
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
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '7');
                      }
                    },
                    labelText: '7',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '8');
                      }
                    },
                    labelText: '8',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '9');
                      }
                    },
                    labelText: '9',
                    backgroundColor: Color(0xFFFEFFFA),
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
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '4');
                      }
                    },
                    labelText: '4',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '5');
                      }
                    },
                    labelText: '5',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '6');
                      }
                    },
                    labelText: '6',
                    backgroundColor: Color(0xFFFEFFFA),
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
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '1');
                      }
                    },
                    labelText: '1',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '2');
                      }
                    },
                    labelText: '2',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '3');
                      }
                    },
                    labelText: '3',
                    backgroundColor: Color(0xFFFEFFFA),
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
                      setState(() => workPassword = '');
                    },
                    labelText: '訂正',
                    backgroundColor: Color(0xFFFFCDD2),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () {
                      if (workPassword.length < 8) {
                        setState(() => workPassword += '0');
                      }
                    },
                    labelText: '0',
                    backgroundColor: Color(0xFFFEFFFA),
                  ),
                ),
                Expanded(
                  child: CustomKeypadButton(
                    onPressed: () async {
                      if (workPassword == '') {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => ErrorMessage(
                            message: '暗証番号を入力してください。',
                          ),
                        );
                        return;
                      }
                      if (!await widget.groupProvider
                          .selectUser(workPassword: workPassword)) {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => ErrorMessage(
                            message: '入力した暗証番号に該当するスタッフが見つかりませんでした。',
                          ),
                        );
                        return;
                      }
                      setState(() => workPassword = '');
                    },
                    labelText: '確定',
                    backgroundColor: Color(0xFFBBDEFB),
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