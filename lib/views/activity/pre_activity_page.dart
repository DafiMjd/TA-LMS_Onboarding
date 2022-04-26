import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/utils/status_utils.dart';
import 'package:lms_onboarding/views/activity/activity_detail_page.dart';
import 'package:lms_onboarding/views/activity/try.dart';
import 'package:lms_onboarding/widgets/space.dart';

class PreActivityPage extends StatelessWidget {
  const PreActivityPage({Key? key, required this.activity}) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity"),
        foregroundColor: Colors.black,
        backgroundColor: ORANGE_GARUDA,
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ActivityTitleCard(activity: activity),
            Space.doubleSpace(),
            ActivityStatusCard(),
            Space.doubleSpace(),
            ActivityNoteCard(),
          ],
        ),
      )),
    );
  }
}

class ActivityNoteCard extends StatelessWidget {
  const ActivityNoteCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Activity Note",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Space.space(),
        Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    maxLines: 2,
                    decoration: const InputDecoration(
                        labelText:
                            "Notes and comments for the employee"),
                  ),
                  Space.space(),
                  ElevatedButton(onPressed: () {}, child: Text("Save")),
                ],
              ),
            )),
      ],
    );
  }
}

class ActivityStatusCard extends StatelessWidget {
  const ActivityStatusCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: STATUSES['on_progress']!['color'],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 86,
                    height: 16,
                    child: Text(
                      STATUSES['on_progress']!['title'],
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10),
                color: CARD_BORDER,
                height: 1,
              ),
              Row(children: [
                Text("Due Date", style: TextStyle(fontSize: 17)),
                Text(": Due Date", style: TextStyle(fontSize: 17)),
              ]),
              SizedBox(
                height: DEFAULT_PADDING,
              ),
              Row(children: [
                Text("Time Remaining", style: TextStyle(fontSize: 17)),
                Text(": Due Date", style: TextStyle(fontSize: 17)),
              ]),
            ],
          ),
        ));
  }
}

class ActivityTitleCard extends StatelessWidget {
  const ActivityTitleCard({
    Key? key,
    required this.activity
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.activity_name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10),
                color: CARD_BORDER,
                height: 1,
              ),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ActivityDetailPage(activity: activity);
                  // return Try();

                }));
              }, child: Text("Enter Activity"))
            ],
          ),
        ));
  }
}
