import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/login.dart';
import 'package:hatarakujikan_tablet/widgets/custom_setting_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/round_border_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  final GroupProvider groupProvider;

  SettingScreen({required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFEFFFA),
        elevation: 0.0,
        centerTitle: true,
        title: Text('各種設定'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        children: [
          SizedBox(height: 16.0),
          Text('アプリ情報'),
          SizedBox(height: 8.0),
          Divider(height: 1.0, color: Colors.grey),
          CustomSettingListTile(
            onTap: () async {
              const url = 'https://www.agora-c.com/';
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              } else {
                throw 'このURLにはアクセスできません';
              }
            },
            iconData: Icons.business_outlined,
            label: '開発/運営会社',
          ),
          SizedBox(height: 24.0),
          RoundBorderButton(
            onPressed: () async {
              await groupProvider.signOut();
              changeScreen(context, LoginScreen());
            },
            label: 'ログアウト',
            color: Colors.blue,
            borderColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
