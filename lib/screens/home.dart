import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/screens/clock.dart';
import 'package:hatarakujikan_tablet/screens/history.dart';
import 'package:hatarakujikan_tablet/screens/keypad.dart';
import 'package:hatarakujikan_tablet/screens/qr.dart';
import 'package:hatarakujikan_tablet/screens/setting.dart';
import 'package:hatarakujikan_tablet/screens/users.dart';
import 'package:hatarakujikan_tablet/screens/work_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupProvider = Provider.of<GroupProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(groupProvider.group?.name ?? ''),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              UsersScreen(groupProvider: groupProvider),
            ),
            icon: Icon(Icons.group),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              QrScreen(groupProvider: groupProvider),
            ),
            icon: Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              SettingScreen(groupProvider: groupProvider),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.teal.shade100,
                    width: double.infinity,
                    child: Clock(groupProvider: groupProvider),
                  ),
                ),
                Container(
                  color: Colors.teal.shade100,
                  padding: EdgeInsets.all(40),
                  child: WorkButton(
                    groupProvider: groupProvider,
                    workProvider: workProvider,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: groupProvider.currentUser == null
                ? Keypad(groupProvider: groupProvider)
                : History(groupProvider: groupProvider),
          ),
        ],
      ),
    );
  }
}
