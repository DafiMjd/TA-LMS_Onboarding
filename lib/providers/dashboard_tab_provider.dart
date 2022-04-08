import 'package:flutter/material.dart';
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

  late String _token, _email;
  void recieveToken(auth) {
    _token = auth.token;
    _email = auth.email;
    notifyListeners();
  }

  bool _isFetchingData = false;
  get isFetchingData => _isFetchingData;
  set isFetchingData(val) {
    _isFetchingData = val;
  }

  Future<User> getUserInfo() async {
    
    // getAuthInfo();
    String apiURL = "$BASE_URL/api/User/$_email";

    try {
      var apiResult = await http.get(
        Uri.parse(apiURL),
        headers: {
          "Access-Control-Allow-Origin":
              "*", // Required for CORS support to work
          "Access-Control-Allow-Methods": "GET",
          "Access-Control-Allow-Credentials": "true",
          "Access-Control-Expose-Headers": "Authorization, authenticated",
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $_token',
        },
      );

      Map<String, dynamic> responseData = jsonDecode(apiResult.body);

      return User.createUser(responseData);

      
    } catch (e) {
      throw (e);
    }
  }

}
