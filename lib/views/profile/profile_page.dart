import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/profile/user_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ProfilePage {
  static AppBar profileAppBar() {
    return AppBar(
      backgroundColor: ORANGE_GARUDA,
      title: Text(
        "Profile",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static Column profileHome(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context);
    final _user = userProv.user;
    return Column(
      children: [
        // profile pic, name, etc
        Container(
          margin: EdgeInsets.all(10),
          height: 120,
          child: Card(
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 13, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(children: [
                        Text(
                          _user.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          _user.jobtitle,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                        )
                      ]),
                      Row(
                        children: [
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontSize: 14, color: EDIT_PROFILE_COLOR),
                          ),
                          VerticalDivider(
                            width: 15,
                          ),
                          Icon(
                            Icons.edit,
                            size: 17,
                            color: EDIT_PROFILE_COLOR,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // detail profile
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
              child: Column(
            children: [
              // Full Name
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Full Name",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _user.name,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              // Job Title
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Job Title",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _user.jobtitle,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              // Email
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Email",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _user.email,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              // Phone Number
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Phone Number",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _user.phone_number,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              // Birth Date
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Birth Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        "Birth Date",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),

              // Gender
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: CARD_BORDER,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        "Gender",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        _user.gender,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
        ),

        // Change Password
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            child: ListTile(
              onTap: () {},
              title: Text("Change Password", style: TextStyle(fontSize: 16)),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ),

        // Logout
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            child: ListTile(
              onTap: () {},
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              trailing: Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
