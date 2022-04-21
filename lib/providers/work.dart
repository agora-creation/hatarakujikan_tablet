import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/define.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/breaks.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/services/user.dart';
import 'package:hatarakujikan_tablet/services/work.dart';

class WorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  WorkService _workService = WorkService();

  Future<bool> workStart({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    try {
      String _id = _workService.id();
      _workService.create({
        'id': _id,
        'groupId': group.id,
        'userId': user.id,
        'startedAt': DateTime.now(),
        'startedLat': 0.0,
        'startedLon': 0.0,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
        'breaks': [],
        'state': workStates.first,
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user.id,
        'workLv': 1,
        'lastWorkId': _id,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> workEnd({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        _breaks.add(_breaksModel.toMap());
      }
      if (group.autoBreak == true) {
        String _breaksId = randomString(20);
        _breaks.add({
          'id': _breaksId,
          'startedAt': DateTime.now(),
          'startedLat': 0.0,
          'startedLon': 0.0,
          'endedAt': DateTime.now().add(Duration(hours: 1)),
          'endedLat': 0.0,
          'endedLon': 0.0,
        });
      }
      _workService.update({
        'id': _work?.id,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user.id,
        'workLv': 0,
        'lastWorkId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakStart({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        _breaks.add(_breaksModel.toMap());
      }
      String _breaksId = randomString(20);
      _breaks.add({
        'id': _breaksId,
        'startedAt': DateTime.now(),
        'startedLat': 0.0,
        'startedLon': 0.0,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
      });
      _workService.update({
        'id': _work?.id,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user.id,
        'workLv': 2,
        'lastBreakId': _breaksId,
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> breakEnd({
    GroupModel? group,
    UserModel? user,
  }) async {
    if (group == null) return false;
    if (user == null) return false;
    WorkModel? _work = await _workService.select(id: user.lastWorkId);
    if (_work?.groupId != group.id) return false;
    if (_work?.userId != user.id) return false;
    try {
      List<Map> _breaks = [];
      for (BreaksModel _breaksModel in _work?.breaks ?? []) {
        if (_breaksModel.id == user.lastBreakId) {
          _breaksModel.endedAt = DateTime.now();
          _breaksModel.endedLat = 0.0;
          _breaksModel.endedLon = 0.0;
        }
        _breaks.add(_breaksModel.toMap());
      }
      _workService.update({
        'id': _work?.id,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user.id,
        'workLv': 1,
        'lastBreakId': '',
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamList({
    String? groupId,
    String? userId,
  }) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    _ret = FirebaseFirestore.instance
        .collection('work')
        .where('groupId', isEqualTo: groupId ?? 'error')
        .where('userId', isEqualTo: userId ?? 'error')
        .orderBy('startedAt', descending: true)
        .snapshots();
    return _ret;
  }
}
