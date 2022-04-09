import 'package:flutter/material.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';

const Map<String, Map<String, dynamic>> STATUSES = {
  "assigned": {"title": "Assigned", "color": STATUS_GREY},
  "on_progress": {"title": "On Progress", "color": STATUS_BLUE},
  "completed": {"title": "Completed", "color": STATUS_YELLOW},
  "validated": {"title": "Validated", "color": STATUS_GREEN},
};
