import 'package:flutter/material.dart';
import 'package:hatarakujikan_tablet/services/user.dart';

class UserProvider with ChangeNotifier {
  UserService _userService = UserService();
}
