import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/section.dart';
import 'package:hatarakujikan_tablet/providers/section.dart';
import 'package:hatarakujikan_tablet/screens/section/home.dart';
import 'package:hatarakujikan_tablet/widgets/custom_select_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class SectionSelectScreen extends StatefulWidget {
  final SectionProvider sectionProvider;

  SectionSelectScreen({@required this.sectionProvider});

  @override
  _SectionSelectScreenState createState() => _SectionSelectScreenState();
}

class _SectionSelectScreenState extends State<SectionSelectScreen> {
  bool _isLoading = false;

  void _init() async {
    setState(() => _isLoading = true);
    await Future.delayed(Duration(seconds: 2));
    if (widget.sectionProvider.sections.length == 1) {
      await widget.sectionProvider.setSection(
        widget.sectionProvider.sections.first,
      );
      setState(() => _isLoading = false);
      Navigator.of(context, rootNavigator: true).pop();
      changeScreen(context, SectionHomeScreen());
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
                '部署/事業所の選択',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    widget.sectionProvider.signOut();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            body: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              itemCount: widget.sectionProvider.sections.length,
              itemBuilder: (_, index) {
                SectionModel _section = widget.sectionProvider.sections[index];
                return CustomSelectListTile(
                  onTap: () async {
                    setState(() => _isLoading = true);
                    await widget.sectionProvider.setSection(_section);
                    setState(() => _isLoading = false);
                    Navigator.of(context, rootNavigator: true).pop();
                    changeScreen(context, SectionHomeScreen());
                  },
                  label:
                      '${widget.sectionProvider.group?.name} (${_section.name})',
                );
              },
            ),
          );
  }
}
