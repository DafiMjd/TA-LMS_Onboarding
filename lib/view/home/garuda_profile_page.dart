import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

class GarudaProfilePage extends StatelessWidget {
  const GarudaProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Pengenalan Perusahaan"),
          backgroundColor: ORANGE_GARUDA,
          foregroundColor: Colors.black),
      body: Center(
        child: Text("Pengenalan Perusahaan"),
      ),
    );
  }
}
