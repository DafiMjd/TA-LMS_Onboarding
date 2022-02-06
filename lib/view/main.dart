import 'package:flutter/material.dart';
import 'package:lms_onboarding/provider/auth_error.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
          create: (context) => AuthError(), child: MainPage()),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(10),
          child: buildAuthCard(),
        ),
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
          Container(
            child: Column(
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
                            Consumer<AuthError>(
                              builder: (context, authError, _) => Visibility(
                                visible: authError.error,
                                child: Container(
                                    margin: EdgeInsets.all(5),
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
                                    )),
                              ),
                            ),
                            TextField(),
                            Consumer<AuthError>(
                              builder: (context, authError, _) => Visibility(
                                visible: authError.error,
                                child: Container(
                                    margin: EdgeInsets.all(5),
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
                                    )),
                              ),
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
                    margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text("Forgot Password?")),
              ],
            ),
          ),
          // email pw
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Login")),
              Consumer<AuthError>(
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
