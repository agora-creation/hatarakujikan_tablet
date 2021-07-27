import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class UsersScreen extends StatelessWidget {
  final GroupProvider groupProvider;

  UsersScreen({@required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('user')
        .where('groups', arrayContains: groupProvider.group.id)
        .orderBy('recordPassword', descending: false)
        .snapshots();
    List<UserModel> users = [];

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
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading(color: Colors.teal);
          }
          users.clear();
          for (DocumentSnapshot user in snapshot.data.docs) {
            users.add(UserModel.fromSnapshot(user));
          }
          if (users.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              itemCount: users.length,
              itemBuilder: (_, index) {
                UserModel _user = users[index];
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
            );
          } else {
            return Center(child: Text('スタッフがいません'));
          }
        },
      ),
    );
  }
}
