import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void nextScreen(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void changeScreen(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
      fullscreenDialog: true,
    ),
  );
}

void overlayScreen(BuildContext context, Widget widget) {
  showMaterialModalBottomSheet(
    expand: true,
    enableDrag: false,
    context: context,
    builder: (context) => widget,
  );
}

String randomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;
  final rand = Random();
  final codeUnits = List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return String.fromCharCodes(codeUnits);
}

Future<String> getPrefs({String key}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(key) ?? '';
}

Future<void> setPrefs({String key, String value}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(key, value);
}

Future<void> removePrefs({String key}) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.remove(key);
}

String twoDigits(int n) => n.toString().padLeft(2, '0');

String addTime(String left, String right) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  List<String> _lefts = left.split(':');
  List<String> _rights = right.split(':');
  double _hm = (int.parse(_lefts.last) + int.parse(_rights.last)) / 60;
  int _m = (int.parse(_lefts.last) + int.parse(_rights.last)) % 60;
  int _h = (int.parse(_lefts.first) + int.parse(_rights.first)) + _hm.toInt();
  if (_h.toString().length == 1) {
    return '${twoDigits(_h)}:${twoDigits(_m)}';
  } else {
    return '$_h:${twoDigits(_m)}';
  }
}

String subTime(String left, String right) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  List<String> _lefts = left.split(':');
  List<String> _rights = right.split(':');
  // 時 → 分
  int _leftM = (int.parse(_lefts.first) * 60) + int.parse(_lefts.last);
  int _rightM = (int.parse(_rights.first) * 60) + int.parse(_rights.last);
  // 分で引き算
  int _diffM = _leftM - _rightM;
  // 分 → 時
  double _h = _diffM / 60;
  int _m = _diffM % 60;
  return '${twoDigits(_h.toInt())}:${twoDigits(_m)}';
}

// DateTime => Timestamp
Timestamp convertTimestamp(DateTime date, bool end) {
  String _dateTime = '${DateFormat('yyyy-MM-dd').format(date)} 00:00:00.000';
  if (end) {
    _dateTime = '${DateFormat('yyyy-MM-dd').format(date)} 23:59:59.999';
  }
  return Timestamp.fromMillisecondsSinceEpoch(
    DateTime.parse(_dateTime).millisecondsSinceEpoch,
  );
}

// バージョンチェック
Future<bool> versionCheck() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  int currentVersion = int.parse(packageInfo.buildNumber);
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  try {
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
    final remoteConfigAppVersionKey = Platform.isIOS
        ? 'tablet_ios_required_semver'
        : 'tablet_android_required_semver';
    int newVersion = remoteConfig.getInt(remoteConfigAppVersionKey);
    if (newVersion > currentVersion) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

// ストアURL
const String iosUrl = 'https://itunes.apple.com/jp/app/id1571904972?mt=8';
const String androidUrl =
    'https://play.google.com/store/apps/details?id=com.agoracreation.hatarakujikan_tablet';

void launchUpdate() async {
  String _url;
  if (Platform.isIOS) {
    _url = iosUrl;
  } else {
    _url = androidUrl;
  }
  if (await canLaunch(_url)) {
    await launch(_url);
  } else {
    throw 'Could not launch $_url';
  }
}
