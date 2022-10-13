import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/providers/group.dart';
import 'package:hatarakujikan_tablet/providers/work.dart';
import 'package:hatarakujikan_tablet/widgets/history_footer.dart';
import 'package:hatarakujikan_tablet/widgets/history_header.dart';
import 'package:hatarakujikan_tablet/widgets/history_list.dart';
import 'package:hatarakujikan_tablet/widgets/icon_label.dart';

class History extends StatefulWidget {
  final GroupProvider groupProvider;
  final WorkProvider workProvider;

  History({
    required this.groupProvider,
    required this.workProvider,
  });

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<WorkModel> works = [];

  @override
  void initState() {
    super.initState();
    widget.groupProvider.countStart();
  }

  @override
  void dispose() {
    super.dispose();
    widget.groupProvider.countStop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconLabel(
          iconData: Icons.list,
          label: '勤務履歴',
        ),
        HistoryHeader(),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: widget.workProvider.streamList(
              groupId: widget.groupProvider.group?.id,
              userId: widget.groupProvider.currentUser?.id,
            ),
            builder: (context, snapshot) {
              works.clear();
              if (snapshot.hasData) {
                for (DocumentSnapshot<Map<String, dynamic>> doc
                    in snapshot.data!.docs) {
                  works.add(WorkModel.fromSnapshot(doc));
                }
              }
              if (works.length == 0) return Text('勤務履歴はありません');
              return ListView.builder(
                itemCount: works.length,
                itemBuilder: (_, index) {
                  return HistoryList(work: works[index]);
                },
              );
            },
          ),
        ),
        HistoryFooter(
          currentSeconds: widget.groupProvider.currentSeconds,
          onTap: () => widget.groupProvider.clearUser(),
        ),
      ],
    );
  }
}
