class User {
  int user_id, role_id;
  String name, gender, phone_number, jobtitle, email;
  double progress;

  User(
      {required this.user_id,
      required this.role_id,
      required this.jobtitle,
      required this.name,
      required this.gender,
      required this.phone_number,
      required this.progress,
      required this.email});
}
