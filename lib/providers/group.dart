import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/services/group.dart';
import 'package:hatarakujikan_tablet/services/user.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class GroupProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;
  FirebaseAuth? _auth;
  User? _fUser;
  GroupService _groupService = GroupService();
  UserService _userService = UserService();
  List<GroupModel> _groups = [];
  GroupModel? _group;

  Status get status => _status;
  User? get fUser => _fUser;
  List<GroupModel> get groups => _groups;
  GroupModel? get group => _group;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidden = false;

  GroupProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth?.authStateChanges().listen(_onStateChanged);
  }

  void changeHidden() {
    isHidden = !isHidden;
    notifyListeners();
  }

  Future setGroup(GroupModel? group) async {
    if (group == null) return;
    _group = group;
    await setPrefs('groupId', group.id);
    _groups.clear();
    notifyListeners();
  }

  Future<bool> signIn() async {
    if (email.text == '') return false;
    if (password.text == '') return false;
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) async {
        _groups.clear();
        _groups = await _groupService.selectListAdminUser(
          userId: value.user?.uid,
        );
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    await _auth!.signOut();
    _status = Status.Unauthenticated;
    _groups.clear();
    _group = null;
    await removePrefs('groupId');
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    email.text = '';
    password.text = '';
  }

  Future reloadGroup() async {
    String? _groupId = await getPrefs('groupId');
    if (_groupId != null) {
      _group = await _groupService.select(id: _groupId);
    }
    notifyListeners();
  }

  Future _onStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _fUser = firebaseUser;
      String? _groupId = await getPrefs('groupId');
      if (_groupId == null) {
        _status = Status.Unauthenticated;
        _groups.clear();
        _group = null;
      } else {
        _status = Status.Authenticated;
        _groups.clear();
        _group = await _groupService.select(id: _groupId);
      }
    }
    notifyListeners();
  }

  UserModel? currentUser;

  Future<bool> setUser({required String recordPassword}) async {
    try {
      String? _groupId = await getPrefs('groupId');
      if (_groupId != null) {
        _group = await _groupService.select(id: _groupId);
      }
      List<UserModel> _users = await _userService.selectList(
        userIds: _group?.userIds ?? [],
      );
      UserModel? _user = _users.singleWhere(
        (e) => e.recordPassword == recordPassword,
      );
      currentUser = _user;
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future reloadUser() async {
    if (currentUser != null) {
      currentUser = await _userService.select(id: currentUser?.id);
      notifyListeners();
    }
  }

  void clearUser() {
    currentUser = null;
    notifyListeners();
  }

  Timer? timer;
  int seconds = 10;
  int currentSeconds = 0;

  void countStart() {
    currentSeconds = seconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentSeconds < 1) {
        timer.cancel();
        currentUser = null;
        notifyListeners();
      } else {
        currentSeconds -= 1;
        notifyListeners();
      }
    });
  }

  void countStop() {
    timer?.cancel();
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? streamUsers() {
    Stream<QuerySnapshot<Map<String, dynamic>>>? _ret;
    _ret = FirebaseFirestore.instance
        .collection('user')
        .orderBy('recordPassword', descending: false)
        .snapshots();
    return _ret;
  }
}
