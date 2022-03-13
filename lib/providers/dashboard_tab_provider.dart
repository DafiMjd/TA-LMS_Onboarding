import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/constans.dart';

class DashboardTabProvider with ChangeNotifier {
  int _tab = HOME_PAGE;

  int get tab => _tab;

  set tab(int val) {
    _tab = val;
    notifyListeners();
  }
}
