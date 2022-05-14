import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/providers/activity/pre_activity_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/utils/formatter.dart';
import 'package:lms_onboarding/utils/status_utils.dart';
import 'package:lms_onboarding/views/activity/activity_detail_page.dart';
import 'package:lms_onboarding/views/dashboard_page.dart';
import 'package:lms_onboarding/widgets/error_alert_dialog.dart';
import 'package:lms_onboarding/widgets/loading_widget.dart';
import 'package:lms_onboarding/widgets/space.dart';
import 'package:provider/provider.dart';

class PreActivityPage extends StatefulWidget {
  const PreActivityPage({Key? key, required this.actOwnedId}) : super(key: key);

  final int actOwnedId;

  @override
  State<PreActivityPage> createState() => _PreActivityPageState();
}

class _PreActivityPageState extends State<PreActivityPage> {
  late PreActivityProvider prov;
  late ActivityOwned actOwned;

  @override
  void initState() {
    super.initState();

    prov = Provider.of(context, listen: false);
    _fetchActOwned(widget.actOwnedId);
  }

  @override
  Widget build(BuildContext context) {
    prov = context.watch<PreActivityProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Activity"),
        foregroundColor: Colors.black,
        backgroundColor: ORANGE_GARUDA,
      ),
      body: (prov.isFetchingData)
          ? LoadingWidget()
          : RefreshIndicator(
              onRefresh: () async {
                refresh();
              },
              child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ActivityTitleCard(activityOwned: actOwned),
                        Space.doubleSpace(),
                        ActivityStatusCard(
                          activityOwned: actOwned,
                        ),
                        Space.doubleSpace(),
                        ActivityNoteCard(
                            activityOwned: actOwned, refresh: refresh),
                      ],
                    ),
                  )),
            ),
    );
  }

  void refresh() {
    setState(() {
      _fetchActOwned(actOwned.id);
    });
  }

  void _error(e) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(error: e.toString(), title: "HTTP Error");
        });
  }

  void _fetchActOwned(int id) async {
    prov.isFetchingData = true;

    try {
      actOwned = await prov.fetchActOwnedById(id);
      print(actOwned.activity.activity_name);
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return _error(e);
    }
  }
}

class ActivityNoteCard extends StatefulWidget {
  const ActivityNoteCard(
      {Key? key, required this.activityOwned, required this.refresh})
      : super(key: key);

  final ActivityOwned activityOwned;
  final Function refresh;

  @override
  State<ActivityNoteCard> createState() => _ActivityNoteCardState();
}

class _ActivityNoteCardState extends State<ActivityNoteCard> {
  late PreActivityProvider prov;

  late TextEditingController _textCtrl;

  @override
  void initState() {
    super.initState();

    prov = Provider.of<PreActivityProvider>(context, listen: false);
    var note = widget.activityOwned.activity_note;
    if (note.isEmpty) {
      _textCtrl = TextEditingController();
    } else {
      _textCtrl = TextEditingController(text: note);
    }
  }

  @override
  Widget build(BuildContext context) {
    prov = context.watch<PreActivityProvider>();

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
                    inputFormatters: <TextInputFormatter>[
                      LengthLimitingTextInputFormatter(200),
                    ],
                    maxLines: 2,
                    controller: _textCtrl,
                    onChanged: (val) {
                      prov.isNoteEmpty = _textCtrl.text.isEmpty;
                    },
                    decoration: const InputDecoration(
                        labelText: "Notes and comments for the employee"),
                  ),
                  Space.space(),
                  ElevatedButton(
                      onPressed: (prov.isNoteEmpty)
                          ? () async {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ErrorAlertDialog(
                                        error: "Error",
                                        title: "Provide Some Activity Note");
                                  });
                            }
                          : () {
                              setActivityNote(
                                  widget.activityOwned.id, _textCtrl.text);

                              widget.refresh();
                            },
                      child: Text("Save")),
                ],
              ),
            )),
      ],
    );
  }

  void setActivityNote(id, note) async {
    prov.isFetchingData = true;
    try {
      await prov.editActivityNote(id, note);
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(title: "Error", error: e.toString());
          });
    }
  }
}

class ActivityStatusCard extends StatelessWidget {
  const ActivityStatusCard({Key? key, required this.activityOwned})
      : super(key: key);

  final ActivityOwned activityOwned;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    var startDate = formatter.format(activityOwned.start_date);
    var dueDate = formatter.format(activityOwned.end_date);

    DateTime x = DateTime.parse('2000-01-01 17:00');
    DateTime y = DateTime.parse('2000-01-04 18:30');
    Map<String, dynamic> difference = Formatter.dateFormatter(
        activityOwned.start_date, activityOwned.end_date);

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
                        color: STATUSES[activityOwned.status]!['color'],
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: 86,
                    height: 16,
                    child: Text(
                      STATUSES[activityOwned.status]!['title'],
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
                Text("Due Date: ", style: TextStyle(fontSize: 17)),
                Text(dueDate, style: TextStyle(fontSize: 17)),
              ]),
              SizedBox(
                height: DEFAULT_PADDING,
              ),
              Row(children: [
                Text("Time Remaining: ", style: TextStyle(fontSize: 17)),
                Text(
                    (difference['difference'].isNegative)
                        ? 'Late ' + difference['difString']
                        : difference['difString'],
                    style: TextStyle(
                        fontSize: 17,
                        color: (difference['difference'].isNegative)
                            ? Colors.red
                            : Colors.black)),
              ]),
            ],
          ),
        ));
  }
}

class ActivityTitleCard extends StatelessWidget {
  const ActivityTitleCard({Key? key, required this.activityOwned})
      : super(key: key);

  final ActivityOwned activityOwned;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PreActivityProvider>(context, listen: false);
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activityOwned.activity.activity_name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 10),
                color: CARD_BORDER,
                height: 1,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (activityOwned.status == 'assigned') {
                      _editActStatus(
                          activityOwned.id, 'on_progress', prov, context);
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ActivityDetailPage(
                        actOwnedId: activityOwned.id,
                        actOwned: activityOwned,
                        act: activityOwned.activity,
                        title: activityOwned.activity.activity_name,
                      );
                      // return Try();
                    }));
                  },
                  child: Text("Enter Activity"))
            ],
          ),
        ));
  }

  _editActStatus(id, status, PreActivityProvider prov, context) async {
    prov.isFetchingData = true;
    try {
      await prov.editActivityStatus(id, status);
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      return showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(title: "Error", error: e.toString());
          });
    }
  }
}
