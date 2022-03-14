import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/views/activity/activity_page.dart';
import 'package:lms_onboarding/views/profile/profile_page.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';

int _currentIndex = 0;

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();
    return page(dashboardTabProvider, context);
  }

  Scaffold page(
      DashboardTabProvider dashboardTabProvider, BuildContext context) {
    if (dashboardTabProvider.tab == HOME_PAGE) {
      return Scaffold(
        appBar: HomePage.homeAppBar(context),
        body: HomePage.homeBody(context),
        bottomNavigationBar: BottomNavBar(),
      );
    } else if (dashboardTabProvider.tab == ACTIVITY_PAGE) {
      return Scaffold(
        appBar: ActivityPage.activityAppBar(),
        body: ActivityPage.activityHome(context),
        bottomNavigationBar: BottomNavBar(),
      );
    } else if (dashboardTabProvider.tab == PROFILE_PAGE) {
      return Scaffold(
        appBar: ProfilePage.profileAppBar(),
        body: ProfilePage.profileHome(context),
        bottomNavigationBar: BottomNavBar(),
      );
    }
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: "", backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.task), label: "", backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box_rounded),
            label: "",
            backgroundColor: Colors.white),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          dashboardTabProvider.tab = index;
        });
      },
    );
  }
}
