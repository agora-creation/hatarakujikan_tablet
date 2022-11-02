import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/error_dialog.dart';
import 'package:hatarakujikan_tablet/widgets/history.dart';
import 'package:hatarakujikan_tablet/widgets/keypad.dart';

class HomeRight extends StatefulWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  HomeRight({
    required this.groupProvider,
    required this.workProvider,
  });

  @override
  State<HomeRight> createState() => _HomeRightState();
}

class _HomeRightState extends State<HomeRight> {
  String recordPassword = '';

  void _add(String num) {
    if (recordPassword.length < 8) {
      setState(() => recordPassword += num);
    }
  }

  void _clear() {
    setState(() => recordPassword = '');
  }

  Future _submit() async {
    if (recordPassword == '') {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => ErrorDialog('暗証番号を入力してください。'),
      );
    } else {
      if (!await widget.groupProvider.setUser(recordPassword: recordPassword)) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => ErrorDialog('入力された暗証番号では認証できませんでした。'),
        );
      } else {
        setState(() => recordPassword = '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: widget.groupProvider.currentUser == null
          ? Keypad(
              recordPassword: recordPassword,
              add: _add,
              clear: _clear,
              submit: _submit,
            )
          : History(
              groupProvider: widget.groupProvider,
              workProvider: widget.workProvider,
            ),
    );
  }
}
