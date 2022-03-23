import 'package:flutter/material.dart';
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
        'state': '通常勤務',
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
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        _breaks.add(breaks.toMap());
      }
      if (group.autoBreak == true) {
        String _id = randomString(20);
        _breaks.add({
          'id': _id,
          'startedAt': DateTime.now(),
          'startedLat': 0.0,
          'startedLon': 0.0,
          'endedAt': DateTime.now().add(Duration(hours: 1)),
          'endedLat': 0.0,
          'endedLon': 0.0,
        });
      }
      _workService.update({
        'id': user.lastWorkId,
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
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        _breaks.add(breaks.toMap());
      }
      String _id = randomString(20);
      _breaks.add({
        'id': _id,
        'startedAt': DateTime.now(),
        'startedLat': 0.0,
        'startedLon': 0.0,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
      });
      _workService.update({
        'id': user.lastWorkId,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user.id,
        'workLv': 2,
        'lastBreakId': _id,
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
    try {
      WorkModel _work = await _workService.select(id: user.lastWorkId);
      if (_work.groupId != group.id) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work.breaks) {
        if (breaks.id == user.lastBreakId) {
          breaks.endedAt = DateTime.now();
          breaks.endedLat = 0.0;
          breaks.endedLon = 0.0;
        }
        _breaks.add(breaks.toMap());
      }
      _workService.update({
        'id': user.lastWorkId,
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
}
