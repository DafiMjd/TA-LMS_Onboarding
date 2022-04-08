import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    String _selectedGenderVal = user.gender;
    List<String> genders = ["Laki-Laki", "Perempuan"];
    String dateSelected = user.birtdate;

    final TextEditingController _emailCtrl =
        TextEditingController(text: user.email);
    final TextEditingController _phoneNumCtrl =
        TextEditingController(text: user.phone_number);
    final TextEditingController _nameCtrl =
        TextEditingController(text: user.name);
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: ORANGE_GARUDA,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size:
                                MediaQuery.of(context).size.height * 0.14 - 20,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: ORANGE_GARUDA,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),

                      // Fullname
                      textField("Full Name"),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      TextFormField(
                          controller: _nameCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),

                      // Email
                      textField("Email"),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      TextFormField(
                          controller: _emailCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),

                      // Phone Number
                      textField("Phone Number"),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      TextFormField(
                          controller: _phoneNumCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),

                      // Birth Date
                      textField("Birth Date"),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 7),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: Colors.black38,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: Colors.black38,
                              width: 1.0,
                            ),
                            left: BorderSide(
                              color: Colors.black38,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(1950, 1, 1),
                                    maxTime: DateTime(2019, 31, 12),
                                    theme: DatePickerTheme(
                                        headerColor: ORANGE_GARUDA,
                                        backgroundColor: BROWN_GARUDA,
                                        itemStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16)), onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  dateSelected = date.toString();
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              },
                              child: Icon(
                                Icons.date_range,
                                size: 30,
                              ),
                            ),
                            VerticalDivider(width: 10, color: Colors.black38),
                            Container(
                              margin: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                dateSelected,
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),

                      // Gender
                      textField("Gender"),
                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      DropdownButtonFormField(
                        hint: Text(_selectedGenderVal),
                        dropdownColor: Colors.white,
                        items: genders.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedGenderVal = value.toString();
                          print("dafi: " + _selectedGenderVal);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),

                      SizedBox(
                        height: DEFAULT_PADDING,
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: Text("Save Changes")),
                    ],
                  ),
                )),
          ),
        ));
  }

  Container textField(title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
