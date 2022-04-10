import 'package:flutter/foundation.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DataProvider extends ChangeNotifier {
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

  // Users
  Future<User> getUserInfo() async {
    // getAuthInfo();
    String apiURL = "$BASE_URL/api/User/$_email";
    print("dafi token: " + _token);

    try {
      var result = await http.get(
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

      print("dafi majid: " + result.body.toString());

      // Map<String, dynamic> responseData = jsonDecode(result.body);

      // return User.createUser(responseData);
      return compute(parseUser, result.body);
    } catch (e) {
      print("dafi e" + e.toString());
      throw (e);
    }
  }

  Future<User> editProfile(
      String name, String gender, String phoneNum, String date) async {
    // getAuthInfo();
    String apiURL = "$BASE_URL/api/User/";

    try {
      var result = await http.put(Uri.parse(apiURL),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Methods": "GET",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Expose-Headers": "Authorization, authenticated",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode({
            "email": _email,
            "name": name,
            "gender": gender,
            "phone_number": phoneNum,
            "birthdate": date,
          }));

      return getUserInfo();
    } catch (e) {
      print("dafi erro " + e.toString());

      throw (e);
    }
  }
  // =======

  // Acitivy Category
  Future<List<ActivityCategory>> fetchActivityCategories() async {
    String url = "$BASE_URL/api/ActivityCategory";

    try {
      var result = await http.get(
        Uri.parse(url),
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

      // var parsed = jsonDecode(result.body);

      // return parsed
      //     .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
      //     .toList();
      return compute(parseActivityCategories, result.body);
    } catch (e) {
      throw (e);
    }
  }
  // =======

  // Change Password
  Future<void> changePassword(String curPass, String newPass) async {
    // getAuthInfo();
    String apiURL = "$BASE_URL/api/User/edit-password";

    try {
      var result = await http.put(Uri.parse(apiURL),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Methods": "GET",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Expose-Headers": "Authorization, authenticated",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode({
            "email": _email,
            "password": curPass,
            "new_password": newPass,
          }));

      Map<String, dynamic> responseData = jsonDecode(result.body);
      if (result.statusCode == 400) {
        throw responseData['errorMessage'];
      }
    } catch (e) {
      rethrow;
    }
  }
  // =======
}

// Acitivy Category
List<ActivityCategory> parseActivityCategories(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
      .toList();
}
// =======

// Users
User parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return User.createUser(parsed);
}
// =======
