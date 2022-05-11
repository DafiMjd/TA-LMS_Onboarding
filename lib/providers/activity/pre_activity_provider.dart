import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_owned.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lms_onboarding/utils/constans.dart';

class PreActivityProvider extends ChangeNotifier {
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
    notifyListeners();
  }

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
    String url = "$BASE_URL/api/ActivitiesOwned/activity-note";

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

      if (result.statusCode == 502) {
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

      if (result.statusCode == 502) {
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

  return ActivityOwned.fromJson(parsed);
}
