import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:lms_onboarding/models/activity.dart';
import 'dart:convert';

import 'package:lms_onboarding/models/activity_detail.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/utils/constans.dart';

class ActivityDetailPageProvider extends ChangeNotifier {
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

  bool _isButtonDisabled = false;
  get isButtonDisabled => _isButtonDisabled;
  set isButtonDisabled(val) {
    _isButtonDisabled = val;
  }

  // API Request

  Future<List<ActivityDetail>> fetchDetailsByActivityId(
      Activity activity) async {
    var id = activity.id;

    String url = "$BASE_URL/api/ActivityDetail/$id";

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

      List<Map<String, dynamic>> parsed =
          jsonDecode(result.body).cast<Map<String, dynamic>>();
      // colnames = getColumnNames(parsed[0]);
      for (int i = 0; i < parsed.length; i++) {
        parsed[i]['activity_'] = activity;
      }

      return compute(parseActivityDetails, parsed);
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

  // ========

}

List<ActivityDetail> parseActivityDetails(List<Map<String, dynamic>> parsed) {
  return parsed
      .map<ActivityDetail>((json) => ActivityDetail.fromJson(json))
      .toList();
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
