import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/functions.dart';
import 'package:hatarakujikan_tablet/models/group.dart';
import 'package:hatarakujikan_tablet/models/section.dart';
import 'package:hatarakujikan_tablet/models/user.dart';
import 'package:hatarakujikan_tablet/services/group.dart';
import 'package:hatarakujikan_tablet/services/section.dart';
import 'package:hatarakujikan_tablet/services/user.dart';

enum Status2 { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class SectionProvider with ChangeNotifier {
  Status2 _status = Status2.Uninitialized;
  FirebaseAuth _auth;
  User _fUser;
  GroupService _groupService = GroupService();
  SectionService _sectionService = SectionService();
  UserService _userService = UserService();
  GroupModel _group;
  List<SectionModel> _sections = [];
  SectionModel _section;
  List<UserModel> _users = [];

  Status2 get status => _status;
  User get fUser => _fUser;
  GroupModel get group => _group;
  List<SectionModel> get sections => _sections;
  SectionModel get section => _section;
  List<UserModel> get users => _users;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isHidden = false;
  UserModel currentUser;

  SectionProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanged);
  }

  void changeHidden() {
    isHidden = !isHidden;
    notifyListeners();
  }

  Future<void> setSection(SectionModel section) async {
    _group = await _groupService.select(id: section.id);
    _sections.clear();
    _section = section;
    _users.clear();
    _users = await _userService.selectList(userIds: _section.userIds);
    _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
    await setPrefs(key: 'sectionId', value: _section.id);
    notifyListeners();
  }

  Future<bool> signIn() async {
    if (email.text == null) return false;
    if (password.text == null) return false;
    try {
      _status = Status2.Authenticating;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((value) async {
        _sections.clear();
        _sections = await _sectionService.selectListAdminUser(
          adminUserId: value.user.uid,
        );
        _group = await _groupService.select(id: _sections.first.groupId);
      });
      return true;
    } catch (e) {
      _status = Status2.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    await _auth.signOut();
    _status = Status2.Unauthenticated;
    _group = null;
    _sections.clear();
    _section = null;
    _users.clear();
    await removePrefs(key: 'sectionId');
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    email.text = '';
    password.text = '';
  }

  Future<void> reloadSectionModel() async {
    String _sectionId = await getPrefs(key: 'sectionId');
    if (_sectionId != '') {
      _section = await _sectionService.select(id: _sectionId);
      _users.clear();
      _users = await _userService.selectList(userIds: _section.userIds);
      _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
      _group = await _groupService.select(id: _section.groupId);
    }
    notifyListeners();
  }

  Future<void> _onStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status2.Unauthenticated;
    } else {
      _fUser = firebaseUser;
      String _sectionId = await getPrefs(key: 'sectionId');
      if (_sectionId == '') {
        _status = Status2.Unauthenticated;
        _group = null;
        _sections.clear();
        _section = null;
      } else {
        _status = Status2.Authenticated;
        _sections.clear();
        _section = await _sectionService.select(id: _sectionId);
        _users.clear();
        _users = await _userService.selectList(userIds: _section.userIds);
        _users.sort((a, b) => a.recordPassword.compareTo(b.recordPassword));
        _group = await _groupService.select(id: _section.id);
      }
    }
    notifyListeners();
  }

  Future<void> reloadUsers() async {
    _users.clear();
    _users = await _userService.selectList(userIds: _section.userIds);
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
