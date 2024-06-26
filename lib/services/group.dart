import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/group.dart';

class GroupService {
  String _collection = 'group';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<GroupModel?> select({String? id}) async {
    GroupModel? _group;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id ?? 'error')
        .get()
        .then((value) {
      _group = GroupModel.fromSnapshot(value);
    });
    return _group;
  }

  Future<List<GroupModel>> selectListAdminUser({String? userId}) async {
    List<GroupModel> _groups = [];
    await _firebaseFirestore
        .collection(_collection)
        .where('adminUserId', isEqualTo: userId ?? 'error')
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) {
      for (DocumentSnapshot<Map<String, dynamic>> _data in value.docs) {
        _groups.add(GroupModel.fromSnapshot(_data));
      }
    });
    return _groups;
  }
}
