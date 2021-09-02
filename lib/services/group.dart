import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/group.dart';

class GroupService {
  String _collection = 'group';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<GroupModel> select({String id}) async {
    GroupModel _group;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id)
        .get()
        .then((value) {
      _group = GroupModel.fromSnapshot(value);
    });
    return _group;
  }

  Future<List<GroupModel>> selectListAdminUser({String adminUserId}) async {
    List<GroupModel> _groups = [];
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .where('adminUserId', isEqualTo: adminUserId)
        .orderBy('createdAt', descending: true)
        .get();
    for (DocumentSnapshot _group in snapshot.docs) {
      _groups.add(GroupModel.fromSnapshot(_group));
    }
    return _groups;
  }
}
