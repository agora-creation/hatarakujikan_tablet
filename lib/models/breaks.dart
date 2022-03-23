import 'package:hatarakujikan_tablet/helpers/functions.dart';

class BreaksModel {
  String _id = '';
  DateTime startedAt = DateTime.now();
  double startedLat = 0;
  double startedLon = 0;
  DateTime endedAt = DateTime.now();
  double endedLat = 0;
  double endedLon = 0;

  String get id => _id;

  BreaksModel.fromMap(Map data) {
    _id = data['id'] ?? '';
    startedAt = data['startedAt'].toDate() ?? DateTime.now();
    startedLat = data['startedLat'].toDouble() ?? 0;
    startedLon = data['startedLon'].toDouble() ?? 0;
    endedAt = data['endedAt'].toDate() ?? DateTime.now();
    endedLat = data['endedLat'].toDouble() ?? 0;
    endedLon = data['endedLon'].toDouble() ?? 0;
  }

  Map toMap() => {
        'id': id,
        'startedAt': startedAt,
        'startedLat': startedLat,
        'startedLon': startedLon,
        'endedAt': endedAt,
        'endedLat': endedLat,
        'endedLon': endedLon,
      };

  String breakTime() {
    String _time = '00:00';
    // 休憩開始時間と休憩終了時間の差を求める
    Duration _diff = endedAt.difference(startedAt);
    String _minutes = twoDigits(_diff.inMinutes.remainder(60));
    _time = '${twoDigits(_diff.inHours)}:$_minutes';
    return _time;
  }
}
