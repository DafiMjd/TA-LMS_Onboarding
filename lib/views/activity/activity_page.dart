import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/providers/activity/category_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/utils/formatter.dart';
import 'package:lms_onboarding/views/bottom_navbar.dart';
import 'package:lms_onboarding/widgets/activity_item.dart';
import 'package:lms_onboarding/widgets/category_item.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage(
      {Key? key, required this.userProgress, required this.categories})
      : super(key: key);

  final double userProgress;
  final List<ActivityCategory> categories;

  @override
  Widget build(BuildContext context) {
    final categoryProv = Provider.of<CategoryProvider>(context);
    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ORANGE_GARUDA,
        title: Text(
          "Activity",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            // Progress Bar
            Flexible(
                flex: 1,
                child: Container(
                  color: PROGRESS_BAR_CARD,
                  margin: EdgeInsets.fromLTRB(35, 15, 35, 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Progress Activity"),
                        LinearPercentIndicator(
                          alignment: MainAxisAlignment.center,
                          width: MediaQuery.of(context).size.width / 2.5,
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2500,
                          percent: userProgress,
                          center: Text(Formatter.doubleToPercent(userProgress),
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: PROGRESS_BAR,
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 80),
                          alignment: Alignment.centerRight,
                          child: Text("35/50"),
                        ),
                      ]),
                )),
            // Acitivty Category
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Activity Category",
                        style: TextStyle(fontSize: 17),
                      )),
                  // Horizontal ListView
                  // (categoryProv.category.isEmpty)
                  //     ? Center(
                  //         child: Text(
                  //           "No Data",
                  //           style: TextStyle(
                  //             fontSize: 25,
                  //           ),
                  //         ),
                  //       )
                  //     : 
                      Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, i) => CategoryItem(
                                  categoryName:
                                      categories[i].categoryName,
                                  categoryColor:
                                      categories[i].categoryColor)),
                        )
                ],
              ),
            ),

            Flexible(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Running Activity",
                            style: TextStyle(fontSize: 17),
                          )),
                      Divider(height: 15, color: Colors.transparent),

                      // activity card
                      ActivityItem(
                        title: "Belajar",
                        description: "Flutter",
                        statusId: "assigned",
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

