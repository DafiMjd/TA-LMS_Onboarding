import 'package:flutter/cupertino.dart';
import 'package:lms_onboarding/models/user.dart';

class UserProvider extends ChangeNotifier {
  final _user = User(
      user_id: 1,
      role_id: 1,
      jobtitle: "Mobile Dev",
      name: "Dafi Majid Fadhlih",
      gender: "Male",
      phone_number: "08112312948",
      email: "dafi.majid@gmail.com",
      progress: 0.8);

  User get user => _user;
}
