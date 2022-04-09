import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';

class CategoryProvider extends ChangeNotifier {
  final List<ActivityCategory> _category = [
    // ActivityCategory(categoryName: "Week 1 Activity", categoryColor: Colors.green, id: 1, categoryDesc: "dafi", duration: 1,),
    
  ];

  List<ActivityCategory> get category => _category;
}
