import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/jobtitle.dart';
import 'package:lms_onboarding/models/role.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/views/activity/activity_page.dart';
import 'package:lms_onboarding/views/bottom_navbar.dart';
import 'package:lms_onboarding/views/home/home_page.dart';
import 'package:lms_onboarding/views/leaderboard/leaderboard_page.dart';
import 'package:lms_onboarding/views/profile/profile_page.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User user;
  late List<ActivityCategory> categories;
  // late DashboardPageProvider dashProv;
  late DashboardTabProvider dashProv;

  void errorFetchingUser(e) async {
    User user = User(
          email: "null",
          name: "null",
          gender: "null",
          phone_number: "null",
          progress: 0,
          birtdate: "null",
          assignedActivities: 0,
          finishedActivities: 0,
        role: Role(id: 0, name: "null"),
          jobtitle: Jobtitle(
              id: 0, jobtitle_name: "null", jobtitle_description: "null"));
  return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("HTTP Error"),
            content: Text("$e"),
            actions: [
              TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text("okay"))
            ],
          );
        });
  }

  void fetchUser() async {
    dashProv.isFetchingData = true;

    try {
      var u = await dashProv.getUserInfo();
      dashProv.user = u;
      dashProv.isFetchingData = false;
    } catch (e) {
      dashProv.isFetchingData = false;
      errorFetchingUser(e);
    }
  }

  void errorFetchingCategories(e) async {
    categories = [];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("HTTP Error"),
            content: Text("$e"),
            actions: [
              TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text("okay"))
            ],
          );
        });
  }

  void fetchCategories() async {
    dashProv.isFetchingData = true;

    try {
      categories = await dashProv.fetchActivityCategories();
      dashProv.isFetchingData = false;
    } catch (e) {
      dashProv.isFetchingData = false;
      errorFetchingCategories(e);
    }
  }

  @override
  void initState() {
    super.initState();
    dashProv = Provider.of<DashboardTabProvider>(context, listen: false);
    fetchUser();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();

    user = dashboardTabProvider.user;

    Widget page() {
      if (dashboardTabProvider.tab == HOME_PAGE) {
        return (dashProv.isFetchingData)
            ? LoadingScreen()
            : HomePage(
                user: user,
              );
      }
      else if (dashboardTabProvider.tab == ACTIVITY_PAGE) {
        return (dashProv.isFetchingData)
            ? LoadingScreen()
            : ActivityPage(
                user: user,
                categories: categories,
              );
      } else if (dashboardTabProvider.tab == PROFILE_PAGE) {
        return (dashProv.isFetchingData)
            ? LoadingScreen()
            : ProfilePage(
                user: user,
              );
      } else if (dashboardTabProvider.tab == LEADERBOARD_PAGE) {
        return (dashProv.isFetchingData) ? LoadingScreen() : LeaderboardPage();
      }
      return Scaffold(
        bottomNavigationBar: BottomNavBar(),
      );
    }

    return page();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
