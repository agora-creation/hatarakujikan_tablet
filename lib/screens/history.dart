import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_footer_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_header_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class History extends StatefulWidget {
  final GroupProvider groupProvider;

  History({@required this.groupProvider});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Timer _timer;
  int _seconds = 10;
  int _currentSeconds;

  Timer countTimer() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentSeconds < 1) {
        timer.cancel();
        widget.groupProvider.clearUser();
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
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: widget.groupProvider.group?.id)
        .where('userId', isEqualTo: widget.groupProvider.currentUser?.id)
        .orderBy('startedAt', descending: true)
        .snapshots();
    List<WorkModel> works = [];

    return Column(
      children: [
        CustomHeaderListTile(
          iconData: Icons.list,
          labelText: '勤務履歴',
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
              for (DocumentSnapshot work in snapshot.data.docs) {
                works.add(WorkModel.fromSnapshot(work));
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
          labelText: '$_currentSeconds秒後、入力に戻る',
          onTap: () => widget.groupProvider.clearUser(),
        ),
      ],
    );
  }
}