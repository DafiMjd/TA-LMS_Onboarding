// ignore_for_file: non_constant_identifier_names

import 'package:lms_onboarding/models/activity.dart';

class ActivityDetail {
  int? id;
  int detail_urutan;
  String detail_name, detail_desc, detail_type;
  String? detail_link;
  Activity activity;

  ActivityDetail(
      {this.id,
      required this.detail_urutan,
      required this.detail_name,
      required this.detail_desc,
      this.detail_link,
      required this.detail_type,
      required this.activity});

  factory ActivityDetail.fromJson(Map<String, dynamic> json) {
    // print("\ndafimajid: $json");
    var newAct = ActivityDetail(
      id: json['id'],
      activity: json['activity_'],
      detail_name: json['detail_name'],
      detail_desc: json['detail_desc'],
      detail_link: json['detail_link'],
      detail_type: json['detail_type'],
      detail_urutan: json['detail_urutan'],
    );
    return newAct;
  }
}
