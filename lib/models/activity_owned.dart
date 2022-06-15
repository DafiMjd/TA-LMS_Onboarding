// ignore_for_file: non_constant_identifier_names

import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/user.dart';

class ActivityOwned {
  int id;
  Activity activity;
  // ActivityCategory? category;
  DateTime start_date, end_date;
  String status, activity_note;
  bool late;
  String? mentor_email;
  User user;
  int category_id;

  ActivityOwned(
      {required this.id,
      required this.activity,
      // required this.category,
      required this.start_date,
      required this.end_date,
      required this.status,
      required this.late,
      this.mentor_email,
      required this.activity_note,
      required this.user,
      required this.category_id});

  factory ActivityOwned.fromJson(Map<String, dynamic> json) {
    var startDate = DateTime.parse(json['start_date']);
    var endDate = DateTime.parse(json['end_date']);
    var note = (json['activity_note'] == null) ? '' : json['activity_note'];
    var cat = (json['category_'] == null)
        ? null
        : ActivityCategory.fromJson(json['category_']);
    return ActivityOwned(
        id: json['id'],
        activity: Activity.fromJson(json['activities_']),
        // category: cat,
        start_date: startDate,
        end_date: endDate,
        status: json['status'],
        late: json['late'],
        mentor_email: json['mentor_email'],
        activity_note: note,
        user: User.fromJson(json['user_']),
        category_id: json['category_id']
        );
  }
}
