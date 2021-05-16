import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/models/groups.dart';

class GroupService {
  String _collection = 'group';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<GroupModel> select({String groupId}) async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection(_collection).doc(groupId).get();
    return GroupModel.fromSnapshot(snapshot);
  }

  Future<List<GroupModel>> selectList({List<GroupsModel> groups}) async {
    List<GroupModel> _groups = [];
    List<String> _whereIn = [];
    for (GroupsModel groupsModel in groups) {
      _whereIn.add(groupsModel.groupId);
    }
    if (_whereIn.length > 0) {
      QuerySnapshot snapshot = await _firebaseFirestore
          .collection(_collection)
          .where('id', whereIn: _whereIn)
          .orderBy('createdAt', descending: true)
          .get();
      for (DocumentSnapshot _group in snapshot.docs) {
        _groups.add(GroupModel.fromSnapshot(_group));
      }
      for (GroupModel groupModel in _groups) {
        for (GroupsModel groupsModel in groups) {
          if (groupModel.id == groupsModel.groupId &&
              groupsModel.fixed == true) {
            groupModel.fixed = true;
          }
        }
      }
    }
    return _groups;
  }
}
