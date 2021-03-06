// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/models/status_menu.dart';
import 'package:lms_onboarding/providers/base_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class BrowseActivityPageProvider extends BaseProvider {
  List<StatusMenu> _menus = [
    StatusMenu(
        id: "all_activity", statusName: "All Activity", selected: false),
    StatusMenu(id: "assigned", statusName: "Assigned", selected: false),
    StatusMenu(id: "on_progress", statusName: "On Progress", selected: false),
    StatusMenu(id: "submitted", statusName: "Submitted", selected: false),
    StatusMenu(id: "late", statusName: "Late", selected: false),
    StatusMenu(id: "Rejected", statusName: "Rejected", selected: false),
    StatusMenu(id: "completed", statusName: "Completed", selected: false),
  ];

  List<StatusMenu> get menus => _menus;
  set menus(val) {
    _menus = val;
    // notifyListeners();
  }

  Container _content = Container();
  get content => _content;
  set content(val) {
    _content = val;
    // notifyListeners();
  }

  // API Request
  Future<Activity> fetchActivityById(int id) async {

    var _token = super.token;
    String url = "$BASE_URL/api/Activities/$id";

     // bool tokenValid = await checkToken();

// if (!tokenValid) {
   // logout();
    // throw 'you have been logged out';
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

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      return compute(parseActivity, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<List<Activity>> fetchActivitiesByCategory(int id) async {

    var _token = super.token;
    String url = "$BASE_URL/api/ActivitiesByCategory/$id";

     // bool tokenValid = await checkToken();

    // if (!tokenValid) {
   // logout();
    // throw 'you have been logged out';
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

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }
      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      return compute(parseActivities, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<List<ActivityOwned>> fetchActOwnedByCat(int id) async {

    var _token = super.token;
    var _email = super.email;
    String url = "$BASE_URL/api/ActivitiesOwnedByCategory/$_email/$id";

     // bool tokenValid = await checkToken();

    
    // if (!tokenValid) {
   // logout();
    // throw 'you have been logged out';
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
        return [];
      }

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      return compute(parseActivitiesOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }

  Future<List<ActivityOwned>> fetchActOwnedByCatByStatus(int id, String status) async {
    var _token = super.token;
    var _email = super.email;
    String url = "$BASE_URL/api/ActivitiesOwnedByCategory/$_email/$id/$status";

     // bool tokenValid = await checkToken();

     
// if (!tokenValid) {
   // logout();
    // throw 'you have been logged out';
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
        return [];
      }

      if (result.statusCode == 502 || result.statusCode == 500) {
        throw "Server Down";
      }

      if (result.statusCode == 400) {
        Map<String, dynamic> responseData = jsonDecode(result.body);
        throw responseData['errorMessage'];
      }

      return compute(parseActivitiesOwned, result.body);
    } catch (e) {
      rethrow;
    }
    

    
  }


  // =======

}

Activity parseActivity(String responseBody) {
  final parsed = jsonDecode(responseBody);

  return Activity.fromJson(parsed);
}

List<Activity> parseActivities(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Activity>((json) => Activity.fromJson(json)).toList();
}

List<ActivityOwned> parseActivitiesOwned(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ActivityOwned>((json) => ActivityOwned.fromJson(json)).toList();
}
