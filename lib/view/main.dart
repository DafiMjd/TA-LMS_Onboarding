import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lms_onboarding/provider/dashboard_tab_provider.dart';
import 'package:lms_onboarding/provider/login_page_provider.dart';
import 'login_page.dart';

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
        ChangeNotifierProvider(create: (context) => LoginPageProvider())
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
