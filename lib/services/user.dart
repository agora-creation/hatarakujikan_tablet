import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/user.dart';

class UserService {
  String _collection = 'user';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  Future<UserModel> select({String groupId, String recordPassword}) async {
    UserModel _user;
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .where('groups', arrayContains: groupId)
        .where('recordPassword', isEqualTo: recordPassword)
        .orderBy('createdAt', descending: true)
        .get();
    if (snapshot.docs.length > 0) {
      _user = UserModel.fromSnapshot(snapshot.docs.first);
    }
    return _user;
  }
}
