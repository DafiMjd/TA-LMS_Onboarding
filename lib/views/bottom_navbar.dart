// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: dashboardTabProvider.botNavBarIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "", backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.task), label: "", backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_outlined),
            label: "",
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "",
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.ac_unit),
            label: "",
            backgroundColor: Colors.white),
      ],
      onTap: (index) {
        dashboardTabProvider.botNavBarIndex = index;
        dashboardTabProvider.tab = dashboardTabProvider.botNavBarIndex;
      },
    );
  }
}
