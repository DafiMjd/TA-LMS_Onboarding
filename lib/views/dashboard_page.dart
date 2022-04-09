import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/jobtitle.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/providers/data_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/views/activity/activity_page.dart';
import 'package:lms_onboarding/views/bottom_navbar.dart';
import 'package:lms_onboarding/views/home/home_page.dart';
import 'package:lms_onboarding/views/profile/profile_page.dart';
import 'package:provider/provider.dart';

int _currentIndex = 0;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User user;
  late List<ActivityCategory> categories;
  late DataProvider dataProv;

  void fetchUser() async {
    dataProv.isFetchingData = true;
    try {
      user = await dataProv.getUserInfo();
    } catch (e) {
      user = User(
          email: "null",
          name: "null",
          gender: "null",
          phone_number: "null",
          progress: 0,
          jobtitle: Jobtitle(
              id: 0, jobtitle_name: "null", jobtitle_description: "null"),
          birtdate: "null");
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
    dataProv.isFetchingData = false;
  }

  void fetchCategories() async {
    dataProv.isFetchingData = true;

    try {
      categories = await dataProv.fetchActivityCategories();

    } catch(e) {
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
    dataProv.isFetchingData = false;

  }

  @override
  void initState() {
    super.initState();
    dataProv = Provider.of<DataProvider>(context, listen: false);
    fetchUser();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();

    Widget page() {
      if (dashboardTabProvider.tab == HOME_PAGE) {
        return (dataProv.isFetchingData)
            ? loadingScreen()
            : HomePage(
                user: user,
              );
      }
      if (dashboardTabProvider.tab == ACTIVITY_PAGE) {
        return (dataProv.isFetchingData)
            ? loadingScreen()
            : ActivityPage(
                userProgress: user.progress,
                categories: categories,
              );
      } else if (dashboardTabProvider.tab == PROFILE_PAGE) {
        return (dataProv.isFetchingData)
            ? loadingScreen()
            : ProfilePage(
                user: user,
              );
      }
      return Scaffold(
        bottomNavigationBar: BottomNavBar(),
      );
    }

    return page();
  }

  Scaffold loadingScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
