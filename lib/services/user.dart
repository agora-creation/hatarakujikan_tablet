import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/user.dart';

class UserService {
  String _collection = 'user';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  Future<UserModel?> select({String? id}) async {
    UserModel? _user;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id)
        .get()
        .then((value) {
      _user = UserModel.fromSnapshot(value);
    });
    return _user;
  }

  Future<List<UserModel>> selectList({List<String>? userIds}) async {
    List<UserModel> _users = [];
    for (String _id in userIds!) {
      await _firebaseFirestore
          .collection(_collection)
          .where('id', isEqualTo: _id)
          .orderBy('recordPassword', descending: false)
          .get()
          .then((value) {
        for (DocumentSnapshot<Map<String, dynamic>> _user in value.docs) {
          _users.add(UserModel.fromSnapshot(_user));
        }
      });
    }
    return _users;
  }
}
