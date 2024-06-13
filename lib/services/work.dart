import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/work.dart';

class WorkService {
  String _collection = 'work';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String id() {
    return _firebaseFirestore.collection(_collection).doc().id;
  }

  void create(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).set(values);
  }

  void update(Map<String, dynamic> values) {
    _firebaseFirestore.collection(_collection).doc(values['id']).update(values);
  }

  Future<WorkModel?> select({String? id}) async {
    WorkModel? _work;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id ?? 'error')
        .get()
        .then((value) {
      _work = WorkModel.fromSnapshot(value);
    });
    return _work;
  }
}
