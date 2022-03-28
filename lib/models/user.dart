import 'package:intl/intl.dart';

class User {
  int progress;

  String email, name, gender, phone_number;
  String birtdate;

  User({
    required this.email,
    required this.name,
    required this.gender,
    required this.phone_number,
    required this.progress,
    required this.birtdate,
  });

  factory User.createUser(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime birtDate = DateTime.parse(json['birthdate']);
    final String dateFormatted = formatter.format(birtDate);


    return User(
        email: json['email'],
        name: json['name'],
        gender: json['gender'],
        phone_number: json['phone_number'],
        progress: json['progress'],
        birtdate: dateFormatted);
  }
}
