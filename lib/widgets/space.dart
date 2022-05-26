// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/constans.dart';

class Space {
  static space() {
    return SizedBox(
      height: DEFAULT_PADDING,
    );
  }
  static doubleSpace() {
    return SizedBox(
      height: DEFAULT_PADDING * 2,
    );
  }
  static tripleSpace() {
    return SizedBox(
      height: DEFAULT_PADDING * 3,
    );
  }
}
