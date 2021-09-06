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
  FirebaseAuth _auth;
  User _fUser;
  GroupService _groupService = GroupService();
  UserService _userService = UserService();
  List<GroupModel> _groups = [];
  GroupModel _group;
  List<UserModel> _users = [];

  Status get status => _status;
  User get fUser => _fUser;
  List<GroupModel> get groups => _groups;
  GroupModel get group => _group;
  List<UserModel> get users => _users;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidden = false;
  UserModel currentUser;

  GroupProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  void changeHidden() {
    isHidden = !isHidden;
    notifyListeners();
  }

  Future<void> setGroup(GroupModel group) async {
    _groups.clear();
    _group = group;
    _users = await _userService.selectList(userIds: _group.userIds);
    _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
    await setPrefs(key: 'groupId', value: group.id);
    notifyListeners();
  }

  Future<bool> signIn() async {
    if (email.text == null) return false;
    if (password.text == null) return false;
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) async {
        _groups.clear();
        _groups = await _groupService.selectListAdminUser(
          adminUserId: value.user.uid,
        );
        _users.clear();
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
    await _auth.signOut();
    _status = Status.Unauthenticated;
    _groups.clear();
    _group = null;
    _users.clear();
    await removePrefs(key: 'groupId');
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    email.text = '';
    password.text = '';
  }

  Future<void> reloadGroupModel() async {
    String _groupId = await getPrefs(key: 'groupId');
    if (_groupId != '') {
      _group = await _groupService.select(id: _groupId);
      _users = await _userService.selectList(userIds: _group.userIds);
      _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
    }
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _fUser = firebaseUser;
      String _groupId = await getPrefs(key: 'groupId');
      if (_groupId == '') {
        _status = Status.Unauthenticated;
        _groups.clear();
        _group = null;
        _users.clear();
      } else {
        _status = Status.Authenticated;
        _groups.clear();
        _group = await _groupService.select(id: _groupId);
        _users = await _userService.selectList(userIds: _group.userIds);
        _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
      }
    }
    notifyListeners();
  }

  Future<void> reloadUsers() async {
    _users = await _userService.selectList(userIds: _group.userIds);
    _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
    notifyListeners();
  }

  Future<bool> currentUserChange({String recordPassword}) async {
    if (recordPassword == '') return false;
    try {
      UserModel _user = _users.singleWhere(
        (e) => e.recordPassword == recordPassword,
      );
      if (_user != null) {
        currentUser = await _userService.select(id: _user.id);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> currentUserReload() async {
    if (currentUser != null) {
      currentUser = await _userService.select(id: currentUser.id);
      notifyListeners();
    }
  }

  void currentUserClear() {
    currentUser = null;
    notifyListeners();
  }
}
