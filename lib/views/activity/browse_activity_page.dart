import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/status_menu.dart';
import 'package:lms_onboarding/providers/activity/browse_activity_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/utils/status_utils.dart';
import 'package:lms_onboarding/views/activity/pre_activity_page.dart';
import 'package:lms_onboarding/views/activity/top_nav_bar.dart';
import 'package:lms_onboarding/widgets/activity_item.dart';
import 'package:lms_onboarding/widgets/space.dart';
import 'package:provider/provider.dart';

class BrowseActivityPage extends StatefulWidget {
  const BrowseActivityPage({Key? key, required this.category})
      : super(key: key);

  final ActivityCategory category;

  @override
  State<BrowseActivityPage> createState() => _BrowseActivityPageState();
}

class _BrowseActivityPageState extends State<BrowseActivityPage> {
  late BrowseActivityPageProvider prov;
  late List<StatusMenu> menus;
  late List<Activity> activities;

  @override
  void initState() {
    super.initState();
    prov = Provider.of<BrowseActivityPageProvider>(context, listen: false);

    initMenu();
    fetchActivities(widget.category.id);
  }

  void initMenu() {
    prov.menus = _changeMenuState(prov.menus, 0);
  }

  void errorFetchingActivities(e) async {
    activities = [];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("HTTP Error"),
            content: Text("$e"),
            actions: [
              TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text("okay"))
            ],
          );
        });
  }

  void fetchActivities(int cat_id) async {
    prov.isFetchingData = true;

    try {
      activities = await prov.fetchActivitiesByCategory(cat_id);
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      errorFetchingActivities(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    BrowseActivityPageProvider prov =
        context.watch<BrowseActivityPageProvider>();

    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: ORANGE_GARUDA,
          title: Text(widget.category.categoryName)),
      body: Column(children: [
        _topNavBarBuilder(),
        Space.space(),
        (prov.isFetchingData)
            ? CircularProgressIndicator()
            :
            // activity card
      
            ListView.builder(
                shrinkWrap: true,
                itemCount: activities.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PreActivityPage(activity: activities[i]);
                    })),
                    child: ActivityItem(
                      title: activities[i].activity_name,
                      description: activities[i].activity_description,
                      statusId: "assigned",
                    ),
                  );
                }),
      ]),
    );
  }

  Container _topNavBarBuilder() {
    List<StatusMenu> menu = context.read<BrowseActivityPageProvider>().menus;
    return Container(
        margin: EdgeInsets.all(15),
        height: 40,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: menu.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  menu = _changeMenuState(menu, i);
                  prov.menus = menu;
                  prov.content = Container(
                    child: Text(menu[i].statusName),
                  );
                },
                child: TopNavBar(
                  menuIndex: i,
                ),
              );
            }));
  }

  List<StatusMenu> _changeMenuState(List<StatusMenu> menu, index) {
    for (int i = 0; i < menu.length; i++) {
      if (i == index) {
        menu[i].selected = true;
      } else {
        menu[i].selected = false;
      }
    }
    return menu;
  }
}
