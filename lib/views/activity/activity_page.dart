// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/models/user.dart';
import 'package:lms_onboarding/providers/activity/activity_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/utils/formatter.dart';
import 'package:lms_onboarding/views/activity/browse_activity_page.dart';
import 'package:lms_onboarding/views/activity/pre_activity_page.dart';
import 'package:lms_onboarding/views/bottom_navbar.dart';
import 'package:lms_onboarding/widgets/activity_item.dart';
import 'package:lms_onboarding/widgets/category_item.dart';
import 'package:lms_onboarding/widgets/error_alert_dialog.dart';
import 'package:lms_onboarding/widgets/loading_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key, required this.user, required this.categories})
      : super(key: key);

  final User user;
  final List<ActivityCategory> categories;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late List<ActivityOwned> actsOwned;
  late List<ActivityCategory> categories;
  late User user;

  late ActivityProvider prov;

  @override
  void initState() {
    super.initState();

    prov = Provider.of<ActivityProvider>(context, listen: false);

    categories = widget.categories;
    user = widget.user;
    _fetchRunningActs();
  }

  @override
  Widget build(BuildContext context) {
    prov = Provider.of<ActivityProvider>(context);

    return Scaffold(
            appBar: AppBar(
              backgroundColor: ORANGE_GARUDA,
              title: Text(
                "Activity",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: (prov.isFetchingData) ? LoadingWidget() :
            RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _fetchCategories();
                  _fetchProgress();
                  _fetchRunningActs();
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      // Progress Bar
                      Flexible(flex: 1, child: ProgressBar(user: user)),
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
                            (categories.isEmpty)
                                ? Center(
                                    child: Text(
                                      "No Data",
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: categories.length,
                                        itemBuilder: (context, i) =>
                                            CategoryItem(
                                              categoryName:
                                                  categories[i].categoryName,
                                              categoryColor:
                                                  categories[i].categoryColor,
                                              press: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return BrowseActivityPage(
                                                      category: categories[i]);
                                                }));
                                              },
                                            )),
                                  )
                          ],
                        ),
                      ),

                      Flexible(
                          flex: 2,
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
                              (actsOwned.isEmpty)
                                  ? Center(
                                      child: Text(
                                        "No Data",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: actsOwned.length,
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          onTap: () => Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return PreActivityPage(
                                                actOwnedId: actsOwned[i].id);
                                          })),
                                          child: ActivityItem(
                                            title: actsOwned[i]
                                                .activity
                                                .activity_name,
                                            description: actsOwned[i]
                                                .activity
                                                .activity_description,
                                            statusId: actsOwned[i].status,
                                          ),
                                        );
                                      }),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavBar(),
          );
  }

  void errorfetchUsers(e) async {
    actsOwned = [];
    return showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(error: "HTTP Error", title: e.toString());
        });
  }

  void _fetchRunningActs() async {
    prov.isFetchingData = true;

    try {
      actsOwned = await prov.fetchActsOwned('on_progress');
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return errorfetchUsers(e);
    }
  }

  void _fetchCategories() async {
    prov.isFetchingData = true;

    try {
      categories = await prov.fetchActivityCategories();
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return errorfetchUsers(e);
    }
  }

  void _fetchProgress() async {
    prov.isFetchingData = true;

    try {
      user = await prov.fetchUser();
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return errorfetchUsers(e);
    }
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PROGRESS_BAR_CARD,
      margin: EdgeInsets.fromLTRB(35, 15, 35, 15),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Text("Progress Activity"),
        LinearPercentIndicator(
          alignment: MainAxisAlignment.center,
          width: MediaQuery.of(context).size.width / 2.5,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: user.progress,
          center: Text(Formatter.doubleToPercent(user.progress),
              style: TextStyle(
                color: Colors.white,
              )),
          linearStrokeCap: LinearStrokeCap.roundAll,
          progressColor: PROGRESS_BAR,
        ),
        Container(
          margin: EdgeInsets.only(right: 80),
          alignment: Alignment.centerRight,
          child: Text(user.finishedActivities.toString() +
              '/' +
              user.assignedActivities.toString()),
        ),
      ]),
    );
  }
}
