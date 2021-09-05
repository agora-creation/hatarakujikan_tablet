import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/models/section.dart';

class SectionService {
  String _collection = 'section';
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<SectionModel> select({String id}) async {
    SectionModel _section;
    await _firebaseFirestore
        .collection(_collection)
        .doc(id)
        .get()
        .then((value) {
      _section = SectionModel.fromSnapshot(value);
    });
    return _section;
  }

  Future<List<SectionModel>> selectListAdminUser({String adminUserId}) async {
    List<SectionModel> _sections = [];
    await _firebaseFirestore
        .collection(_collection)
        .where('adminUserId', isEqualTo: adminUserId)
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) {
      for (DocumentSnapshot _section in value.docs) {
        _sections.add(SectionModel.fromSnapshot(_section));
      }
    });
    return _sections;
  }
}
