import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/breaks.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/models/work.dart';
import 'package:hatarakujikan_tablet/services/user.dart';
import 'package:hatarakujikan_tablet/services/work.dart';

class WorkProvider with ChangeNotifier {
  UserService _userService = UserService();
  WorkService _workService = WorkService();

  Future<bool> workStart({
    String groupId,
    UserModel user,
    String device,
  }) async {
    if (groupId == '') return false;
    if (user == null) return false;
    try {
      String _id = _workService.id();
      _workService.create({
        'id': _id,
        'groupId': groupId,
        'userId': user?.id,
        'startedAt': DateTime.now(),
        'startedLat': 0.0,
        'startedLon': 0.0,
        'startedDev': device,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
        'endedDev': device,
        'breaks': [],
        'state': '通常勤務',
        'createdAt': DateTime.now(),
      });
      _userService.update({
        'id': user?.id,
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
    String groupId,
    UserModel user,
    String device,
  }) async {
    if (groupId == '') return false;
    if (user == null) return false;
    try {
      WorkModel _work = await _workService.select(workId: user?.lastWorkId);
      if (_work?.groupId != groupId) {
        return false;
      }
      _workService.update({
        'id': user?.lastWorkId,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
        'endedDev': device,
      });
      _userService.update({
        'id': user?.id,
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
    String groupId,
    UserModel user,
    String device,
  }) async {
    if (groupId == '') return false;
    if (user == null) return false;
    try {
      WorkModel _work = await _workService.select(workId: user?.lastWorkId);
      if (_work?.groupId != groupId) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work?.breaks) {
        _breaks.add(breaks.toMap());
      }
      String _id = randomString(20);
      _breaks.add({
        'id': _id,
        'startedAt': DateTime.now(),
        'startedLat': 0.0,
        'startedLon': 0.0,
        'startedDev': device,
        'endedAt': DateTime.now(),
        'endedLat': 0.0,
        'endedLon': 0.0,
        'endedDev': device,
      });
      _workService.update({
        'id': user?.lastWorkId,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user?.id,
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
    String groupId,
    UserModel user,
    String device,
  }) async {
    if (groupId == '') return false;
    if (user == null) return false;
    try {
      WorkModel _work = await _workService.select(workId: user?.lastWorkId);
      if (_work?.groupId != groupId) {
        return false;
      }
      List<Map> _breaks = [];
      for (BreaksModel breaks in _work?.breaks) {
        if (breaks.id == user?.lastBreakId) {
          breaks.endedAt = DateTime.now();
          breaks.endedLat = 0.0;
          breaks.endedLon = 0.0;
          breaks.endedDev = device;
        }
        _breaks.add(breaks.toMap());
      }
      _workService.update({
        'id': user?.lastWorkId,
        'breaks': _breaks,
      });
      _userService.update({
        'id': user?.id,
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
