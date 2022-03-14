import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/activity/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;

  CategoryItem({required this.categoryName, required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CategoryProvider>(context, listen: false);

    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
          left: 18,
          right: 18,
        ),
        width: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: categoryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: MediaQuery.of(context).size.height * 0.1,
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
