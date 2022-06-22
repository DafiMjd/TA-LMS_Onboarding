import 'package:flutter/foundation.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/models/user.dart';

import 'package:http/http.dart' as http;
import 'package:lms_onboarding/providers/base_provider.dart';
import 'dart:convert';

import 'package:lms_onboarding/utils/constans.dart';

class ActivityProvider extends BaseProvider {

  // Request API

  Future<User> fetchUser() async {

    var _token = super.token;
    var _email = super.email;
    String url = "$BASE_URL/api/User/$_email";

    bool tokenValid = await checkToken();

    // if (!tokenValid) {
    //   logout();
    //   throw 'you have been logged out';
    // }

    
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
        if (result.statusCode == 400) {
          Map<String, dynamic> responseData = jsonDecode(result.body);
          throw responseData['errorMessage'];
        }
        if (result.statusCode == 502 || result.statusCode == 500) {
          throw "Server Down";
        }
        return compute(parseUser, result.body);
      } catch (e) {
        rethrow;
      }
    
  }

  Future<List<ActivityCategory>> fetchActivityCategories() async {

    var _token = super.token;
    String url = "$BASE_URL/api/ActivityCategory";

     bool tokenValid = await checkToken();

    // if (!tokenValid) {
    //   logout();
    //   throw 'you have been logged out';
    // }

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
      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }
      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      return compute(parseActivityCategories, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<List<ActivityOwned>> fetchActsOwned(String status) async {

    var _token = super.token;
    var _email = super.email;
    String url = "$BASE_URL/api/ActivitiesOwned/$_email/$status";

     bool tokenValid = await checkToken();

    // if (!tokenValid) {
    //   logout();
    //   throw 'you have been logged out';
    // }
    
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
      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }
      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      return compute(parseActivitiesOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  // ===========
}

List<ActivityOwned> parseActivitiesOwned(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<ActivityOwned>((json) => ActivityOwned.fromJson(json))
      .toList();
}

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

User parseUser(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return User.fromJson(parsed);
}
