import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/activity/activity_detail_provider.dart';
import 'package:lms_onboarding/providers/activity/browse_activity_provider.dart';
import 'package:lms_onboarding/providers/activity/category_provider.dart';
import 'package:lms_onboarding/providers/activity/pre_activity_provider.dart';
import 'package:lms_onboarding/providers/profile/change_password_provider.dart';
import 'package:lms_onboarding/providers/profile/edit_profile_provider.dart';
import 'package:lms_onboarding/providers/profile/user_provider.dart';
import 'package:lms_onboarding/views/activity/browse_activity_page.dart';
import 'package:lms_onboarding/views/dashboard_page.dart';
import 'package:provider/provider.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/providers/auth_provider.dart';
import 'views/login_page.dart';

void main() {
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
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProxyProvider<AuthProvider, BrowseActivityPageProvider>(
          create: (context) => BrowseActivityPageProvider(),
          update: (context, authProv, dashPorv) {
              if (dashPorv != null) {

              return dashPorv..recieveToken(authProv);
              }
                return BrowseActivityPageProvider();

          }
        ),
        ChangeNotifierProxyProvider<AuthProvider, DashboardTabProvider>(
          create: (context) => DashboardTabProvider(),
          update: (context, authProv, dashPorv) {
              if (dashPorv != null) {

              return dashPorv..recieveToken(authProv);
              }
                return DashboardTabProvider();

          }
        ),
        ChangeNotifierProxyProvider<AuthProvider, ChangePasswordProvider>(
          create: (context) => ChangePasswordProvider(),
          update: (context, authProv, dashPorv) {
              if (dashPorv != null) {

              return dashPorv..recieveToken(authProv);
              }
                return ChangePasswordProvider();

          }
        ),
        ChangeNotifierProxyProvider<AuthProvider, EditProfileProvider>(
          create: (context) => EditProfileProvider(),
          update: (context, authProv, editProv) {
              if (editProv != null) {

              return editProv..recieveToken(authProv);
              }
                return EditProfileProvider();

          }
        ),
        ChangeNotifierProxyProvider<AuthProvider, ActivityDetailPageProvider>(
          create: (context) => ActivityDetailPageProvider(),
          update: (context, authProv, editProv) {
              if (editProv != null) {

              return editProv..recieveToken(authProv);
              }
                return ActivityDetailPageProvider();

          }
        ),
        ChangeNotifierProxyProvider<AuthProvider, PreActivityProvider>(
          create: (context) => PreActivityProvider(),
          update: (context, authProv, preActProv) {
              if (preActProv != null) {

              return preActProv..recieveToken(authProv);
              }
                return PreActivityProvider();

          }
        ),
      
      ],
      builder: (context, child) => Consumer<AuthProvider>(
          builder: (context, auth, child) => MaterialApp(
                home: auth.getIsAuth() ? DashboardPage() : LoginPage(),
              )),
    );
  }
}
