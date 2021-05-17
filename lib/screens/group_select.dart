import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';

class GroupSelect extends StatelessWidget {
  final GroupProvider groupProvider;

  GroupSelect({@required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '会社/組織の選択',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        itemCount: groupProvider.groups.length,
        itemBuilder: (_, index) {
          return Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              title: Text('アゴラ・クリエーションで利用開始する'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
