import 'package:flutter/cupertino.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/auth_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/auth_secure_storage.dart';

class UserProvider extends ChangeNotifier {

  late User _user;
  void reveiveUser(user) {
    _user = user;
  }
  get user => _user;
  

 }
