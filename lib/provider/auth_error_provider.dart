import 'package:flutter/material.dart';

class AuthError with ChangeNotifier {
  bool _isError = false;

  bool get isError => _isError;

  set isError(bool val) {
    _isError = val;

    notifyListeners();
  }

  bool get error => (_isError) ? false : true;
}
