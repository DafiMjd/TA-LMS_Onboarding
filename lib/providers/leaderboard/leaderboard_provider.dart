import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/utils/constans.dart';

class LeaderboardProvider extends ChangeNotifier {
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

  // Request API

  Future<List<User>> fetchUsers(role_id) async {
    String url = "$BASE_URL/api/UsersByRole/$role_id";

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
      return compute(parseUsers, result.body);
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List> _readFileByte(String filePath) async {
    Uri myUri = Uri.parse(filePath);
    File audioFile = new File.fromUri(myUri);
    late Uint8List bytes;
    await audioFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('dafi: ' + bytes.toString());
    }).catchError((onError) {
      print('Exception Error while reading audio from path:' +
          onError.toString());
    });
    return bytes;
  }

  // ============

}

List<User> parseUsers(String responseBody) {
  List<Map<String, dynamic>> parsed =
      jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
