import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_detail.dart';
import 'package:lms_onboarding/providers/activity/activity_detail_provider.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:provider/provider.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage({Key? key, required this.activity})
      : super(key: key);

  final Activity activity;

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late List<ActivityDetail> actDetails;
  late ActivityDetailPageProvider prov;

  @override
  void initState() {
    super.initState();
    prov = Provider.of<ActivityDetailPageProvider>(context, listen: false);

    fetchActivityDetails(widget.activity);
  }

  void errorFetchingActivityDetails(e) async {
    actDetails = [];
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

  void fetchActivityDetails(Activity activity) async {
    prov.isFetchingData = true;

    try {
      actDetails = await prov.fetchDetailsByActivityId(activity);
      actDetails.forEach((element) {print(element.detail_desc);});
      prov.isFetchingData = false;
    } catch (e) {
      prov.isFetchingData = false;
      errorFetchingActivityDetails(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ORANGE_GARUDA,
          foregroundColor: Colors.black,
          title: Text(widget.activity.activity_name)),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Card(
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ActivityDetailWidget(
                  type: 'header',
                  text: 'Deskripsi',
                ),
                ActivityDetailWidget(
                  type: 'text',
                  text: widget.activity.activity_description,
                ),
                (prov.isFetchingData)
                    ? CircularProgressIndicator()
                    : (actDetails.isEmpty)
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: actDetails.length,
                            itemBuilder: (context, i) {
                              return ActivityDetailWidget(
                                detail: actDetails[i],
                              );
                            }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class ActivityDetailWidget extends StatefulWidget {
  const ActivityDetailWidget({Key? key, this.detail, this.type, this.text})
      : super(key: key);

  final ActivityDetail? detail;
  final String? type;
  final String? text;

  @override
  State<ActivityDetailWidget> createState() => _ActivityDetailWidgetState();
}

class _ActivityDetailWidgetState extends State<ActivityDetailWidget> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    if (widget.detail == null) {
      return _getDeskripsi();
    }
    return _getDetailContent();
  }

  Container _getDetailContent() {
    if (widget.detail!.detail_type == 'header') {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          widget.detail!.detail_desc,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else if (widget.detail!.detail_type == 'text') {
      return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(widget.detail!.detail_desc));
    } else if (widget.detail!.detail_type == 'to_do') {
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
            ),
            Text(widget.detail!.detail_desc),
          ],
        ),
      );
    }
    return Container();
  }

  Container _getDeskripsi() {
    if (widget.type == 'header') {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Text(
          widget.text!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else if (widget.type == 'text') {
      return Container(
          margin: EdgeInsets.only(bottom: 10), child: Text(widget.text!));
    } else {
      return Container();
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      // MaterialState.hovered,
      MaterialState.focused,
    };
    // hovered
    // if (states.any(interactiveStates.contains)) {
    //   return Colors.blue;
    // }
    return Colors.black;
  }
}
