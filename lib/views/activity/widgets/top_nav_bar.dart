// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/status_menu.dart';
import 'package:lms_onboarding/providers/activity/browse_activity_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class TopNavBar extends StatelessWidget {
  const TopNavBar({
    Key? key,
    required this.menuIndex,
  }) : super(key: key);

  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    StatusMenu menu = context.read<BrowseActivityPageProvider>().menus.elementAt(menuIndex);
    bool selected = menu.selected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(

      color: (selected) ? BROWN_GARUDA : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: BROWN_GARUDA)),
      child: Center(
        child: Text(menu.statusName,
            style: TextStyle(
                fontSize: 15,
                color: (selected) ? Colors.white : BROWN_GARUDA,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}