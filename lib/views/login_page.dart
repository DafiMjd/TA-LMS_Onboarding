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
      body: Column(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                height: 100,
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
          Container(
              margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.height,
              child: buildAuthCard()),
        ],
      ),
    );
  }

  Card buildAuthCard() {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "Login to your account",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          // email pw
          Column(
            children: [
              // textfield and warning email
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          TextField(),
                          Consumer<LoginPageProvider>(
                            builder: (context, authError, _) => Container(
                                margin: EdgeInsets.all(5),
                                child: Visibility(
                                  visible: authError.error,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "Email/Phone number is required",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          TextField(),
                          Consumer<LoginPageProvider>(
                            builder: (context, authError, _) => Container(
                                margin: EdgeInsets.all(5),
                                child: Visibility(
                                  visible: authError.error,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.warning,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        "Password number is required",
                                        style: TextStyle(color: Colors.red),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //------------------------------- email & pw//

              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Text("Forgot Password?")),
            ],
          ),
          // email pw
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return DashboardPage();
                    }));
                  },
                  child: Text("Login")),
              Consumer<LoginPageProvider>(
                builder: (context, applicationColor, _) => Switch(
                  value: applicationColor.isError,
                  onChanged: (newValue) {
                    applicationColor.isError = newValue;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
