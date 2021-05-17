import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/setting.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(groupProvider.group?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              SettingScreen(groupProvider: groupProvider),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
