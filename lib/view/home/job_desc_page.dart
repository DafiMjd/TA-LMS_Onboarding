import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

class JobDescPage extends StatelessWidget {
  const JobDescPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Job Desc"),
          backgroundColor: ORANGE_GARUDA,
          foregroundColor: Colors.black),
      body: Center(
        child: Text("Job Desc"),
      ),
    );
  }
}
