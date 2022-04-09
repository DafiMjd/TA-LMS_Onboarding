import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {


  bool _isEmailFieldEmpty = false;
  bool _isNameFieldEmpty = false;
  bool _isPhoneNumFieldEmpty = false;

  bool get isEmailFieldEmpty => _isEmailFieldEmpty;
  bool get isNameFieldEmpty => _isNameFieldEmpty;
  bool get isPhoneNumFieldEmpty => _isPhoneNumFieldEmpty;


  set isEmailFieldEmpty(bool val) {
    _isEmailFieldEmpty = val;
    notifyListeners();
  }
  set isNameFieldEmpty(bool val) {
    _isNameFieldEmpty = val;
    notifyListeners();
  }
  set isPhoneNumFieldEmpty(bool val) {
    _isPhoneNumFieldEmpty = val;
    notifyListeners();
  }

  // button disable after save
  bool _isSaveButtonDisabled = false;

  bool get isSaveButtonDisabled => _isSaveButtonDisabled;
  set isSaveButtonDisabled(bool val) {
    _isSaveButtonDisabled = val;
    notifyListeners();
  }
  // ==========================
  
}