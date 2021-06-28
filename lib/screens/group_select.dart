import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/home.dart';

class GroupSelect extends StatefulWidget {
  final GroupProvider groupProvider;

  GroupSelect({@required this.groupProvider});

  @override
  _GroupSelectState createState() => _GroupSelectState();
}

class _GroupSelectState extends State<GroupSelect> {
  void _init() async {
    if (widget.groupProvider.groups.length == 1) {
      await widget.groupProvider.setGroup(widget.groupProvider.groups.first);
      Navigator.of(context, rootNavigator: true).pop();
      changeScreen(context, HomeScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

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
            onPressed: () {
              widget.groupProvider.signOut();
              Navigator.of(context, rootNavigator: true).pop();
            },
            icon: Icon(Icons.close, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        itemCount: widget.groupProvider.groups.length,
        itemBuilder: (_, index) {
          GroupModel _group = widget.groupProvider.groups[index];
          return Container(
            decoration: kBottomBorderDecoration,
            child: ListTile(
              onTap: () async {
                await widget.groupProvider.setGroup(_group);
                Navigator.of(context, rootNavigator: true).pop();
                changeScreen(context, HomeScreen());
              },
              title: Text('${_group.name}'),
              trailing: Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
