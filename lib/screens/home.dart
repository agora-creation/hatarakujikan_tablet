import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/screens/home_left.dart';
import 'package:hatarakujikan_tablet/screens/home_right.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);
    GroupModel? group = groupProvider.group;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(group?.name ?? ''),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.directions_run),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeLeft(groupProvider: groupProvider, workProvider: workProvider),
          HomeRight(groupProvider: groupProvider, workProvider: workProvider),
        ],
      ),
    );
  }
}
