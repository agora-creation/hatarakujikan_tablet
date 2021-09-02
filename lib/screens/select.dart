import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/screens/home.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class SelectScreen extends StatefulWidget {
  final GroupProvider groupProvider;

  SelectScreen({@required this.groupProvider});

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool _isLoading = false;

  void _init() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    if (widget.groupProvider.groups.length == 1) {
      await widget.groupProvider.setGroup(widget.groupProvider.groups.first);
      setState(() => _isLoading = false);
      Navigator.of(context, rootNavigator: true).pop();
      changeScreen(context, HomeScreen());
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading(color: Colors.teal)
        : Scaffold(
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
                      setState(() => _isLoading = true);
                      await widget.groupProvider.setGroup(_group);
                      setState(() => _isLoading = false);
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
