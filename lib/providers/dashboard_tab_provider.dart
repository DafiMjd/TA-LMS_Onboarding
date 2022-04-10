import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/jobtitle.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardTabProvider with ChangeNotifier {
  int _botNavBarIndex = 0;
  get botNavBarIndex => _botNavBarIndex;
  set botNavBarIndex(val) {
    _botNavBarIndex = val;
  }

  int _tab = HOME_PAGE;
  int get tab => _tab;
  set tab(int val) {
    _tab = val;
    notifyListeners();
  }

  User _user = User(
          email: "null",
          name: "null",
          gender: "null",
          phone_number: "null",
          progress: 0,
          birtdate: "null",
          jobtitle: Jobtitle(
              id: 0, jobtitle_name: "null", jobtitle_description: "null"));
  get user => _user;
  set user(val) {
    _user = val;
    notifyListeners();
  }
  
}
