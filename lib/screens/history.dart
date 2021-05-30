import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/widgets/custom_footer_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_head_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_header_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/custom_history_list_tile.dart';
import 'package:hatarakujikan_tablet/widgets/loading.dart';

class History extends StatelessWidget {
  final GroupProvider groupProvider;

  History({@required this.groupProvider});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: groupProvider.group?.id)
        .where('userId', isEqualTo: groupProvider.currentUser?.id)
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
              return ListView.builder(
                itemCount: works.length,
                itemBuilder: (_, index) {
                  return CustomHistoryListTile(work: works[index]);
                },
              );
            },
          ),
        ),
        CustomFooterListTile(onTap: () => groupProvider.clearUser()),
      ],
    );
  }
}
