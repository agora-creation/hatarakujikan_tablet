import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/providers/section.dart';
import 'package:hatarakujikan_tablet/widgets/custom_footer_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_header_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class SectionHistory extends StatefulWidget {
  final SectionProvider sectionProvider;

  SectionHistory({@required this.sectionProvider});

  @override
  _SectionHistoryState createState() => _SectionHistoryState();
}

class _SectionHistoryState extends State<SectionHistory> {
  Timer _timer;
  int _seconds = 10;
  int _currentSeconds;

  Timer countTimer() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds < 1) {
        timer.cancel();
        widget.sectionProvider.currentUserClear();
      } else {
        setState(() => _currentSeconds -= 1);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentSeconds = _seconds;
    _timer = countTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    GroupModel _group = widget.sectionProvider.group;
    UserModel _user = widget.sectionProvider.currentUser;
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: _group?.id ?? 'error')
        .where('userId', isEqualTo: _user?.id ?? 'error')
        .orderBy('startedAt', descending: true)
        .snapshots();
    List<WorkModel> works = [];

    return Column(
      children: [
        CustomHeaderListTile(
          iconData: Icons.list,
          label: '勤務履歴',
        ),
        CustomHeadListTile(),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading(color: Colors.teal);
              }
              works.clear();
              for (DocumentSnapshot doc in snapshot.data.docs) {
                works.add(WorkModel.fromSnapshot(doc));
              }
              if (works.length > 0) {
                return ListView.builder(
                  itemCount: works.length,
                  itemBuilder: (_, index) {
                    return CustomHistoryListTile(work: works[index]);
                  },
                );
              } else {
                return Center(child: Text('勤務履歴はありません'));
              }
            },
          ),
        ),
        CustomFooterListTile(
          onTap: () => widget.sectionProvider.currentUserClear(),
          label: '$_currentSeconds秒後、入力に戻る',
        ),
      ],
    );
  }
}
