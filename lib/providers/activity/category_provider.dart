import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Category> _category = [
    Category(categoryName: "Week 1 Activity", categoryColor: Colors.amber),
    Category(categoryName: "30 Days Activity", categoryColor: Colors.amber),
    Category(categoryName: "60 Days Activity", categoryColor: Colors.green),
    Category(categoryName: "90 Days Activity", categoryColor: Colors.green),
    Category(
        categoryName: "120 Days Activity", categoryColor: Colors.redAccent),
    Category(
        categoryName: "150 Days Activity", categoryColor: Colors.redAccent),
  ];

  List<Category> get category => _category;
}
