import 'package:flutter/material.dart';

class DashboardTab with ChangeNotifier {
  int _page = 0;

  int get page => _page;

  set page(int val) {
    _page = val;
    notifyListeners();
  }
}
