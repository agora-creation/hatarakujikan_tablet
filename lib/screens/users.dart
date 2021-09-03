import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_user_list_tile.dart';

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
          return CustomUserListTile(user: _user);
        },
      ),
    );
  }
}
