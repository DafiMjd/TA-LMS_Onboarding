import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

class ActivityPage {
  static AppBar activityAppBar() {
    return AppBar(
      backgroundColor: ORANGE_GARUDA,
      title: Text(
        "Activity",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static Container activityHome(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Activity"),
      ),
    );
  }
}
