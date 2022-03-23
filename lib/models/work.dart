import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/breaks.dart';

class WorkModel {
  String _id = '';
  String _groupId = '';
  String _userId = '';
  DateTime startedAt = DateTime.now();
  double startedLat = 0;
  double startedLon = 0;
  DateTime endedAt = DateTime.now();
  double endedLat = 0;
  double endedLon = 0;
  List<BreaksModel> breaks = [];
  String _state = '';
  DateTime _createdAt = DateTime.now();

  String get id => _id;
  String get groupId => _groupId;
  String get userId => _userId;
  String get state => _state;
  DateTime get createdAt => _createdAt;

  WorkModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _id = snapshot.data()!['id'] ?? '';
    _groupId = snapshot.data()!['groupId'] ?? '';
    _userId = snapshot.data()!['userId'] ?? '';
    startedAt = snapshot.data()!['startedAt'].toDate() ?? DateTime.now();
    startedLat = snapshot.data()!['startedLat'].toDouble() ?? 0;
    startedLon = snapshot.data()!['startedLon'].toDouble() ?? 0;
    endedAt = snapshot.data()!['endedAt'].toDate() ?? DateTime.now();
    endedLat = snapshot.data()!['endedLat'].toDouble() ?? 0;
    endedLon = snapshot.data()!['endedLon'].toDouble() ?? 0;
    breaks = _convertBreaks(snapshot.data()!['breaks']);
    _state = snapshot.data()!['state'] ?? '';
    _createdAt = snapshot.data()!['createdAt'].toDate() ?? DateTime.now();
  }

  List<BreaksModel> _convertBreaks(List breaks) {
    List<BreaksModel> converted = [];
    for (Map data in breaks) {
      converted.add(BreaksModel.fromMap(data));
    }
    return converted;
  }

  String startTime() {
    String _time = dateText('HH:mm', startedAt);
    return _time;
  }

  String endTime() {
    String _time = dateText('HH:mm', endedAt);
    return _time;
  }

  String breakTime() {
    String _time = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _time = addTime(_time, _break.breakTime());
      }
    }
    return _time;
  }

  String workTime() {
    String _time = '00:00';
    String _startedDate = dateText('yyyy-MM-dd', startedAt);
    String _startedTime = '${startTime()}:00.000';
    DateTime _startedAt = DateTime.parse('$_startedDate $_startedTime');
    String _endedDate = dateText('yyyy-MM-dd', endedAt);
    String _endedTime = '${endTime()}:00.000';
    DateTime _endedAt = DateTime.parse('$_endedDate $_endedTime');
    // 出勤時間と退勤時間の差を求める
    Duration _diff = _endedAt.difference(_startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    // 休憩の合計時間を求める
    String _breakTime = '00:00';
    if (breaks.length > 0) {
      for (BreaksModel _break in breaks) {
        _breakTime = addTime(_breakTime, _break.breakTime());
      }
    }
    // 勤務時間と休憩の合計時間の差を求める
    _time = subTime(_time, _breakTime);
    return _time;
  }
}
