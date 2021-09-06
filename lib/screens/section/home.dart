import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/section.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/screens/clock.dart';
import 'package:hatarakujikan_tablet/screens/qr.dart';
import 'package:hatarakujikan_tablet/screens/section/history.dart';
import 'package:hatarakujikan_tablet/screens/section/keypad.dart';
import 'package:hatarakujikan_tablet/screens/section/setting.dart';
import 'package:hatarakujikan_tablet/screens/section/work_button.dart';
import 'package:hatarakujikan_tablet/screens/users.dart';
import 'package:provider/provider.dart';

class SectionHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sectionProvider = Provider.of<SectionProvider>(context);
    final workProvider = Provider.of<WorkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '${sectionProvider.group?.name} (${sectionProvider.section?.name})',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await sectionProvider.reloadUsers();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              UsersScreen(users: sectionProvider.users),
            ),
            icon: Icon(Icons.group),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              QrScreen(group: sectionProvider.group),
            ),
            icon: Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              SectionSettingScreen(sectionProvider: sectionProvider),
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
                    child: Clock(user: sectionProvider.currentUser),
                  ),
                ),
                Container(
                  color: Colors.teal.shade100,
                  padding: EdgeInsets.all(40),
                  child: SectionWorkButton(
                    sectionProvider: sectionProvider,
                    workProvider: workProvider,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: sectionProvider.currentUser == null
                ? SectionKeypad(sectionProvider: sectionProvider)
                : SectionHistory(sectionProvider: sectionProvider),
          ),
        ],
      ),
    );
  }
}
