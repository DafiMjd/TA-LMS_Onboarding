import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/activity/category_provider.dart';
import 'package:lms_onboarding/providers/profile/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/providers/login_page_provider.dart';
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
        ChangeNotifierProvider(create: (context) => DashboardTabProvider()),
        ChangeNotifierProvider(create: (context) => LoginPageProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
