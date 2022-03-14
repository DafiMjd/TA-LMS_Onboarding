import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/activity/category_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/widgets/category_item.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ActivityPage {
  static AppBar activityAppBar() {
    return AppBar(
      backgroundColor: ORANGE_GARUDA,
      title: Text(
        "Activity",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static Center activityHome(BuildContext context) {
    final categoryProv = Provider.of<CategoryProvider>(context);
    final ScrollController _scrollController = ScrollController();

    return Center(
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
                        percent: 0.8,
                        center: Text("80.0%",
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
                (categoryProv.category.isEmpty)
                    ? Center(
                        child: Text(
                          "No Data",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      )
                    : Expanded(
                        child: Scrollbar(
                          controller: _scrollController,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProv.category.length,
                              itemBuilder: (context, i) => CategoryItem(
                                  categoryName:
                                      categoryProv.category[i].categoryName,
                                  categoryColor:
                                      categoryProv.category[i].categoryColor)),
                        ),
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
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text("\$dfsadfsaf"),
                            ),
                          ),
                        ),
                        title: Text("dafdsafdsaf"),
                        subtitle: Text("Last Edited : sdafsadf"),
                        trailing: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              color: STATUS_BLUE,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          width: 86,
                          height: 16,
                          child: Text(
                            "On Progress",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
