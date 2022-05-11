import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity_category.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/models/status_menu.dart';
import 'package:lms_onboarding/providers/activity/browse_activity_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
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
  late List<ActivityOwned> activitiesOwned;

  @override
  void initState() {
    super.initState();
    prov = Provider.of<BrowseActivityPageProvider>(context, listen: false);

    initMenu();
    fetchActivities(widget.category.id, 'all_activity');
  }

  void initMenu() {
    prov.menus = _changeMenuState(prov.menus, 0);
  }

  void errorFetchingActivities(e) async {
    activitiesOwned = [];
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

  void fetchActivities(int cat_id, String status) async {
    prov.isFetchingData = true;

    String allActId = context.read<BrowseActivityPageProvider>().menus[0].id;

    try {
      if (status == allActId) {
        activitiesOwned = await prov.fetchActOwnedByCat(cat_id);
      } else {
        activitiesOwned = await prov.fetchActOwnedByCatByStatus(cat_id, status);
      }
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
            : (activitiesOwned.isEmpty)
                ? Text(
                    'No Activity',
                    style: TextStyle(fontSize: 24),
                  )
                :
                // activity card

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: activitiesOwned.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PreActivityPage(
                              activityOwned: activitiesOwned[i]);
                        })),
                        child: ActivityItem(
                          title: activitiesOwned[i].activity.activity_name,
                          description:
                              activitiesOwned[i].activity.activity_description,
                          statusId: activitiesOwned[i].status,
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
                  fetchActivities(widget.category.id, menu[i].id);
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
