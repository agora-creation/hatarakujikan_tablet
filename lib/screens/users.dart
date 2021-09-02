import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';

class UsersScreen extends StatelessWidget {
  final GroupProvider groupProvider;

  UsersScreen({@required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('スタッフの出勤状況'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        itemCount: groupProvider.users.length,
        itemBuilder: (_, index) {
          UserModel _user = groupProvider.users[index];
          Widget _workLv;
          if (_user.workLv == 0) {
            _workLv = Text('');
          } else if (_user.workLv == 1) {
            _workLv = Chip(
              backgroundColor: Colors.blue,
              label: Text('出勤中', style: TextStyle(color: Colors.white)),
            );
          } else if (_user.workLv == 2) {
            _workLv = Chip(
              backgroundColor: Colors.orange,
              label: Text('休憩中', style: TextStyle(color: Colors.white)),
            );
          } else {
            _workLv = Text('');
          }
          return Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('${_user.name}'),
              trailing: _workLv,
            ),
          );
        },
      ),
    );
  }
}
