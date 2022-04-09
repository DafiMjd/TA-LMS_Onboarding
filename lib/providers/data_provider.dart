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

  Future<void> editProfile(
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

      print("dafi majid: " + result.body.toString());
    } catch (e) {
      print("dafi erro " + e.toString());

      throw (e);
    }
  }

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

      var parsed = jsonDecode(result.body);

      return parsed
          .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
          .toList();
    } catch (e) {
      throw (e);
    }
  }

  List<ActivityCategory> parseActivityCategories(String responseBody) {
    List<Map<String, dynamic>> parsed =
        jsonDecode(responseBody).cast<Map<String, dynamic>>();


    return parsed
        .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
        .toList();
  }
}
