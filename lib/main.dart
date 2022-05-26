// ignore_for_file: prefer_const_constructors

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lms_onboarding/providers/activity/activity_detail_provider.dart';
import 'package:lms_onboarding/providers/activity/browse_activity_provider.dart';
import 'package:lms_onboarding/providers/activity/activity_provider.dart';
import 'package:lms_onboarding/providers/activity/pre_activity_provider.dart';
import 'package:lms_onboarding/providers/home/home_activity_detail_provider.dart';
import 'package:lms_onboarding/providers/home/home_provider.dart';
import 'package:lms_onboarding/providers/leaderboard/leaderboard_provider.dart';
import 'package:lms_onboarding/providers/profile/change_password_provider.dart';
import 'package:lms_onboarding/providers/profile/edit_profile_provider.dart';
import 'package:lms_onboarding/providers/profile/user_provider.dart';
import 'package:lms_onboarding/views/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/providers/auth_provider.dart';
import 'views/login_page.dart';

void main() async {
    AutoOrientation.portraitUpMode;
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: false, ignoreSsl: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => DashboardTabProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProxyProvider<AuthProvider, BrowseActivityPageProvider>(
            create: (context) => BrowseActivityPageProvider(),
            update: (context, authProv, dashPorv) {
              if (dashPorv != null) {
                return dashPorv..recieveToken(authProv);
              }
              return BrowseActivityPageProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, DashboardTabProvider>(
            create: (context) => DashboardTabProvider(),
            update: (context, authProv, dashPorv) {
              if (dashPorv != null) {
                return dashPorv..recieveToken(authProv);
              }
              return DashboardTabProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, ChangePasswordProvider>(
            create: (context) => ChangePasswordProvider(),
            update: (context, authProv, dashPorv) {
              if (dashPorv != null) {
                return dashPorv..recieveToken(authProv);
              }
              return ChangePasswordProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, EditProfileProvider>(
            create: (context) => EditProfileProvider(),
            update: (context, authProv, editProv) {
              if (editProv != null) {
                return editProv..recieveToken(authProv);
              }
              return EditProfileProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, ActivityDetailProvider>(
            create: (context) => ActivityDetailProvider(),
            update: (context, authProv, editProv) {
              if (editProv != null) {
                return editProv..recieveToken(authProv);
              }
              return ActivityDetailProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, PreActivityProvider>(
            create: (context) => PreActivityProvider(),
            update: (context, authProv, preActProv) {
              if (preActProv != null) {
                return preActProv..recieveToken(authProv);
              }
              return PreActivityProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, LeaderboardProvider>(
            create: (context) => LeaderboardProvider(),
            update: (context, authProv, leaderboardProv) {
              if (leaderboardProv != null) {
                return leaderboardProv..recieveToken(authProv);
              }
              return LeaderboardProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, ActivityProvider>(
            create: (context) => ActivityProvider(),
            update: (context, authProv, actProv) {
              if (actProv != null) {
                return actProv..recieveToken(authProv);
              }
              return ActivityProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, HomeProvider>(
            create: (context) => HomeProvider(),
            update: (context, authProv, homeProv) {
              if (homeProv != null) {
                return homeProv..recieveToken(authProv);
              }
              return HomeProvider();
            }),
        ChangeNotifierProxyProvider<AuthProvider, HomeActivityDetailProvider>(
            create: (context) => HomeActivityDetailProvider(),
            update: (context, authProv, homeActDetailProv) {
              if (homeActDetailProv != null) {
                return homeActDetailProv..recieveToken(authProv);
              }
              return HomeActivityDetailProvider();
            }),
      ],
      builder: (context, child) => Consumer<AuthProvider>(
          builder: (context, auth, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: auth.getIsAuth() ? DashboardPage() : LoginPage(),
              )),
    );
  }
}
