import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/widgets/icon_label.dart';
import 'package:hatarakujikan_tablet/widgets/keypad_input.dart';
import 'package:hatarakujikan_tablet/widgets/keypad_output.dart';

class Keypad extends StatelessWidget {
  final String recordPassword;
  final Function(String) add;
  final Function() clear;
  final Function() submit;

  Keypad({
    required this.recordPassword,
    required this.add,
    required this.clear,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconLabel(
          iconData: Icons.dialpad,
          label: '暗証番号入力',
        ),
        KeypadOutput(recordPassword: recordPassword),
        Expanded(
          child: Container(
            color: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                KeypadInput(
                  label: '7',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('7'),
                ),
                KeypadInput(
                  label: '8',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('8'),
                ),
                KeypadInput(
                  label: '9',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('9'),
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
                KeypadInput(
                  label: '4',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('4'),
                ),
                KeypadInput(
                  label: '5',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('5'),
                ),
                KeypadInput(
                  label: '6',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('6'),
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
                KeypadInput(
                  label: '1',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('1'),
                ),
                KeypadInput(
                  label: '2',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('2'),
                ),
                KeypadInput(
                  label: '3',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('3'),
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
                KeypadInput(
                  label: '訂正',
                  backgroundColor: Color(0xFFFFCDD2),
                  onPressed: () => clear(),
                ),
                KeypadInput(
                  label: '0',
                  backgroundColor: Color(0xFFFEFFFA),
                  onPressed: () => add('0'),
                ),
                KeypadInput(
                  label: '確定',
                  backgroundColor: Color(0xFFBBDEFB),
                  onPressed: () async => await submit(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
