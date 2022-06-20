import 'package:flutter/foundation.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/jobtitle.dart';
import 'package:lms_onboarding/models/role.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/base_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardTabProvider extends BaseProvider {
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
          assignedActivities: 0,
          finishedActivities: 0,
        role: Role(id: 0, name: "null"),
          jobtitle: Jobtitle(
              id: 0, jobtitle_name: "null", jobtitle_description: "null"));
  get user => _user;
  set user(val) {
    _user = val;
    notifyListeners();
  }


  // Users
  Future<User> getUserInfo() async {

    var _token = super.token;
    var _email = super.email;
    String apiURL = "$BASE_URL/api/User/$_email";

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

      if (result.statusCode == 404) {
        throw "Not Found";
      }

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      return compute(parseUser, result.body);
    } catch (e) {
      rethrow;
    }
  }

  // =======

  // Acitivy Category
  Future<List<ActivityCategory>> fetchActivityCategories() async {

    var _token = super.token;
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

      if (result.statusCode == 404) {
        throw "Not Found";
      }

      
      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      // var parsed = jsonDecode(result.body);

      // return parsed
      //     .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
      //     .toList();

      return compute(parseActivityCategories, result.body);
    } catch (e) {
      rethrow;
    }
  }
  // =======
  
}

// Acitivy Category
List<ActivityCategory> parseActivityCategories(String responseBody) {
  try {
    List<Map<String, dynamic>> parsed =
        jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<ActivityCategory>((json) => ActivityCategory.fromJson(json))
        .toList();
  } catch (e) {
    rethrow;
  }
}
// =======

// Users
User parseUser(String responseBody) {
  try {
    final parsed = jsonDecode(responseBody);

    return User.fromJson(parsed);
  } catch (e) {
    rethrow;
  }
}
// =======
