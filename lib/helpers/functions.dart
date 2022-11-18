import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/helpers/style.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<String?> getPrefs(String key) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(key);
}

Future<void> setPrefs(String key, String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(key, value);
}

Future<void> removePrefs(String key) async {
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

String dateText(String format, DateTime? date) {
  String _ret = '';
  if (date != null) {
    _ret = DateFormat(format, 'ja').format(date);
  }
  return _ret;
}

void customSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message ?? '')),
  );
}

void versionCheck(BuildContext context) {
  final newVersion = NewVersion(
    androidId: ANDROID_APP_ID,
    iOSId: IOS_BUNDLE_ID,
    iOSAppStoreCountry: 'JP',
  );
  _advancedStatusCheck(newVersion, context);
}

void _advancedStatusCheck(NewVersion newVersion, BuildContext context) async {
  final status = await newVersion.getVersionStatus();
  if (status != null && status.canUpdate) {
    String storeVersion = status.storeVersion;
    String releaseNote = status.releaseNotes.toString();
    newVersion.showUpdateDialog(
      context: context,
      versionStatus: status,
      dialogTitle: 'アップデートが必要です。',
      dialogText:
          'Ver.$storeVersionが公開されています。¥n最新バージョンにアップデートをお願いします。¥n¥nバージョンアップ内容は以下の通りです。¥n$releaseNote',
      updateButtonText: 'アップデート',
      allowDismissal: false,
    );
  }
}
