import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/login_page_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:provider/provider.dart';

import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(children: [
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.height / 3,
                    child: Image.asset('assets/images/logo_garuda.png'),
                  ),
                  Text("Onboarding HR",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: BROWN_GARUDA)),
                ],
              ),
            ),
            Divider(height: 30, color: Colors.transparent),
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: BuildAuthCard(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Card BuildAuthCard() {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Login to your account",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Email"),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Email"),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                    onTap: () {},
                    child: Text("Forgot Password?",
                        style: TextStyle(fontWeight: FontWeight.w500)))),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return DashboardPage();
                  }));
                },
                child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
