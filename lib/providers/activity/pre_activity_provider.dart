// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:lms_onboarding/models/activity_owned.dart';

import 'package:http/http.dart' as http;
import 'package:lms_onboarding/providers/base_provider.dart';
import 'dart:convert';

import 'package:lms_onboarding/utils/constans.dart';

class PreActivityProvider extends BaseProvider {

  bool _isLate = false;
  get isLate => _isLate;
  set isLate(val) {
    _isLate = val;
    // notifyListeners();
  }

  bool _isNoteEmpty = true;
  get isNoteEmpty => _isNoteEmpty;
  set isNoteEmpty(val) {
    _isNoteEmpty = val;
    notifyListeners();
  }

  // API Request

  Future<List<ActivityOwned>> editActivityNote(int id, String note) async {
    var _token = super.token;
    var _email = super.email;
    String url = "$BASE_URL/api/ActivitiesOwned/activity-note";

     bool tokenValid = await checkToken();

     // if (!tokenValid) {
    //   logout();
    //   throw 'you have been logged out';
    // }

    try {
      var result = await http.put(Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Methods": "GET",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Expose-Headers": "Authorization, authenticated",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode(
              {"id": id, "user_email": _email, "activity_note": note}));

      if (result.statusCode == 404) {
        throw "Not Found";
      }
      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      if (result.body == '[]') {
        return [];
      }

      return compute(parseActivitiesOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<List<ActivityOwned>> editActivityStatus(int id, String status) async {
    String url = "$BASE_URL/api/ActivitiesOwned/status";

    var _token = super.token;
    var _email = super.email;

     bool tokenValid = await checkToken();

// if (!tokenValid) {
    //   logout();
    //   throw 'you have been logged out';
    // }
    
      try {
      var result = await http.put(Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin":
                "*", // Required for CORS support to work
            "Access-Control-Allow-Methods": "GET",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Expose-Headers": "Authorization, authenticated",
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $_token',
          },
          body: jsonEncode({"id": id, "user_email": _email, "status": status}));
      if (result.statusCode == 404) {
        throw "Not Found";
      }
      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      if (result.body == '[]') {
        return [];
      }

      return compute(parseActivitiesOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<ActivityOwned> fetchActOwnedById(int id) async {

    var _token = super.token;
    String url = "$BASE_URL/api/ActivitiesOwnedById/$id";

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

      if (result.body == []) {
        throw "No Data";
      }

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      return compute(parseActivityOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  // ========

}

List<ActivityOwned> parseActivitiesOwned(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<ActivityOwned>((json) => ActivityOwned.fromJson(json))
      .toList();
}

ActivityOwned parseActivityOwned(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return ActivityOwned.fromJson(parsed[0]);
}
