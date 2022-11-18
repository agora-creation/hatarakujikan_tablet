import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/screens/home_left.dart';
import 'package:hatarakujikan_tablet/screens/home_right.dart';
import 'package:hatarakujikan_tablet/screens/login.dart';
import 'package:hatarakujikan_tablet/screens/qr.dart';
import 'package:hatarakujikan_tablet/screens/users.dart';
import 'package:hatarakujikan_tablet/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    versionCheck(context);
  }

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
            icon: Icon(Icons.directions_run),
            onPressed: () => overlayScreen(
              context,
              UsersScreen(groupProvider: groupProvider),
            ),
          ),
          IconButton(
            icon: Icon(Icons.qr_code),
            onPressed: () => overlayScreen(
              context,
              QrScreen(group: group),
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => SignOutDialog(groupProvider: groupProvider),
              );
            },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeLeft(
            groupProvider: groupProvider,
            workProvider: workProvider,
          ),
          HomeRight(
            groupProvider: groupProvider,
            workProvider: workProvider,
          ),
        ],
      ),
    );
  }
}

class SignOutDialog extends StatelessWidget {
  final GroupProvider groupProvider;

  SignOutDialog({required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.red,
              size: 32.0,
            ),
          ),
          SizedBox(height: 24.0),
          Text(
            'ログアウトします。よろしいですか？',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 24.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                label: 'キャンセル',
                color: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                label: 'はい',
                color: Colors.blue,
                onPressed: () async {
                  await groupProvider.signOut();
                  changeScreen(context, LoginScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
