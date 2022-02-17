import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

class ProfilePage {
  static AppBar profileAppBar() {
    return AppBar(
      backgroundColor: ORANGE_GARUDA,
      title: Text(
        "Profile",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static Container profileHome(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Profile"),
      ),
    );
  }
}
