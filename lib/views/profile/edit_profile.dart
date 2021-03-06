// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/dashboard_tab_provider.dart';
import 'package:lms_onboarding/providers/profile/edit_profile_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/widgets/space.dart';

import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneNumCtrl;
  late final TextEditingController _nameCtrl;
  late String _selectedGenderVal;
  late DateTime _datePicked;
  final List<String> _genders = ["Laki-Laki", "Perempuan"];

  late EditProfileProvider editProv;
  late DashboardTabProvider dashProv;

  void _editUser(String email, String name, String phoneNum, DateTime birthdate,
      String gender) async {
    editProv.isSaveButtonDisabled = true;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(birthdate);

    try {
      dashProv.user = await editProv.editProfile(
          name,
          gender,
          phoneNum,
          dateFormatted,
          widget.user.progress,
          widget.user.role!.id,
          widget.user.jobtitle!.id);
    } catch (onError) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("HTTP Error"),
              content: Text("$onError"),
              actions: [
                TextButton(
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    child: Text("okay"))
              ],
            );
          });
    }
    // Navigator.pop(context);
    Navigator.pop(context);
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
    editProv.isSaveButtonDisabled = false;
  }

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController(text: widget.user.email);
    _phoneNumCtrl = TextEditingController(text: widget.user.phone_number);
    _nameCtrl = TextEditingController(text: widget.user.name);

    _selectedGenderVal = widget.user.gender;
    _datePicked = DateTime.parse(widget.user.birtdate);

    editProv = Provider.of<EditProfileProvider>(context, listen: false);

    dashProv = Provider.of<DashboardTabProvider>(context, listen: false);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _datePicked,
        firstDate: DateTime(1),
        lastDate: DateTime(2101),
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: ORANGE_GARUDA,
                colorScheme: ColorScheme.light(primary: ORANGE_GARUDA),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!);
        });

    if (picked != null && picked != _datePicked) {
      setState(() {
        _datePicked = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
          ),
          foregroundColor: Colors.black,
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
                      Space.space(),

                      // Fullname
                      titleField("Fullname", editProv.isNameFieldEmpty),
                      Space.space(),
                      TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(100),
                          ],
                          onChanged: (value) => editProv.isNameFieldEmpty =
                              _nameCtrl.text.isEmpty,
                          controller: _nameCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                      Space.space(),

                      // Phone Number
                      titleField("Phone Number", editProv.isPhoneNumFieldEmpty),
                      Space.space(),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            LengthLimitingTextInputFormatter(15),
                          ],
                          onChanged: (value) => editProv.isPhoneNumFieldEmpty =
                              _phoneNumCtrl.text.isEmpty,
                          controller: _phoneNumCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          )),
                      Space.space(),

                      // Birth Date
                      textField("Birth Date"),
                      Space.space(),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
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
                              Icon(
                                Icons.date_range,
                                size: 30,
                              ),
                              VerticalDivider(width: 10, color: Colors.black38),
                              Container(
                                margin: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  _datePicked.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Space.space(),

                      // Gender
                      textField("Gender"),
                      Space.space(),
                      DropdownButtonFormField(
                        hint: Text(_selectedGenderVal),
                        dropdownColor: Colors.white,
                        items: _genders.map((val) {
                          return DropdownMenuItem(
                            value: val,
                            child: Text(
                              val,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedGenderVal = value.toString();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),

                      Space.space(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: editProv.isSaveButtonDisabled
                                ? Colors.blue[300]
                                : Colors.blue),
                        onPressed: (editProv.isSaveButtonDisabled)
                            ? () {}
                            : () {
                                if (_emailCtrl.text.isNotEmpty &&
                                    _nameCtrl.text.isNotEmpty &&
                                    _phoneNumCtrl.text.isNotEmpty) {
                                  _editUser(
                                      _emailCtrl.text,
                                      _nameCtrl.text,
                                      _phoneNumCtrl.text,
                                      _datePicked,
                                      _selectedGenderVal);
                                }
                              },
                        child: editProv.isSaveButtonDisabled
                            ? Text(
                                "Wait",
                              )
                            : Text(
                                "Save Changes",
                              ),
                      ),
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

  Container titleField(title, isEmpty) => Container(
      alignment: Alignment.centerLeft,
      child: (isEmpty)
          ? Text(
              title + "*",
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red),
            )
          : Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ));
}
