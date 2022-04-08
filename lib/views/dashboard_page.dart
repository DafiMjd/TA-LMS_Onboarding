import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/jobtitle.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/views/activity/activity_page.dart';
import 'package:lms_onboarding/views/profile/profile_page.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';

int _currentIndex = 0;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late User user;

  void getUser() async {
    DashboardTabProvider dashboardTabProvider =
        Provider.of<DashboardTabProvider>(context, listen: false);

    dashboardTabProvider.isFetchingData = true;
    try {
      user = await dashboardTabProvider.getUserInfo();
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
    dashboardTabProvider.isFetchingData = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

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
        appBar: (dashboardTabProvider.isFetchingData)
            ? PreferredSize(
                child: AppBar(
                  backgroundColor: ORANGE_GARUDA,
                  flexibleSpace: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 30,
                      left: 20,
                    ),
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height / 5))
            : HomePage.homeAppBar(context, user),
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
        body: (dashboardTabProvider.isFetchingData)
            ? CircularProgressIndicator()
            : ProfilePage.profileHome(context, user),
        bottomNavigationBar: BottomNavBar(),
      );
    }
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardTabProvider dashboardTabProvider =
        context.watch<DashboardTabProvider>();
    return BottomNavigationBar(
      currentIndex: dashboardTabProvider.botNavBarIndex,
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
        dashboardTabProvider.botNavBarIndex = index;
        dashboardTabProvider.tab = dashboardTabProvider.botNavBarIndex;
      },
    );
  }
}
