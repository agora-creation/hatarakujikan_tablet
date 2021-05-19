import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/user.dart';

class UserService {
  String _collection = 'user';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  Future<List<UserModel>> selectList({String groupId}) async {
    List<UserModel> _users = [];
    QuerySnapshot snapshot = await _firebaseFirestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();
    for (DocumentSnapshot _user in snapshot.docs) {
      _users.add(UserModel.fromSnapshot(_user));
    }
    return _users;
  }
}
