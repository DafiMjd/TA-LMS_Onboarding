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
        child: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  color: Colors.grey,
                  margin: EdgeInsets.fromLTRB(35, 15, 35, 15),
                )),
            Flexible(flex: 1, child: Container(color: Colors.blue)),
            Flexible(flex: 2, child: Container(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
