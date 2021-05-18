import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/clock.dart';
import 'package:hatarakujikan_tablet/screens/setting.dart';
import 'package:hatarakujikan_tablet/screens/work_button.dart';
import 'package:hatarakujikan_tablet/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_user_list_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dateText = '';
  String timeText = '';

  void _onTimer(Timer timer) {
    var _now = DateTime.now();
    var _dateFormat = DateFormat('yyyy/MM/dd (E)', 'ja');
    var _timeFormat = DateFormat('HH:mm:ss');
    var _dateText = _dateFormat.format(_now);
    var _timeText = _timeFormat.format(_now);
    if (mounted) {
      setState(() {
        dateText = _dateText;
        timeText = _timeText;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), _onTimer);
  }

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
                    child: Clock(
                      dateText: dateText,
                      timeText: timeText,
                      messageText: 'スタッフを選んでください',
                    ),
                  ),
                ),
                Container(
                  color: Colors.teal.shade100,
                  padding: EdgeInsets.all(32.0),
                  child: WorkButton(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                CustomHeadListTile(),
                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (_, index) {
                      return CustomUserListTile();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
