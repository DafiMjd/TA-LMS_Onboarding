// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_detail.dart';
import 'package:lms_onboarding/models/activity_owned.dart';
import 'package:lms_onboarding/providers/activity/activity_detail_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';

import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/views/activity/widgets/detail_pdf.dart';
import 'package:lms_onboarding/views/activity/widgets/detail_video_player.dart';
import 'package:lms_onboarding/views/test/youtube_player.dart';

import 'package:lms_onboarding/widgets/error_alert_dialog.dart';
import 'package:lms_onboarding/widgets/loading_widget.dart';
import 'package:lms_onboarding/widgets/space.dart';
import 'package:provider/provider.dart';

class ActivityDetailPage extends StatefulWidget {
  const ActivityDetailPage(
      {Key? key,
      required this.actOwnedId,
      required this.actOwned,
      required this.act,
      required this.title})
      : super(key: key);

  final int actOwnedId;
  final ActivityOwned actOwned;
  final Activity act;
  final String title;

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  late List<ActivityDetail> actDetails;
  late ActivityDetailProvider prov;
  late ActivityOwned actOwned;

  @override
  void initState() {
    super.initState();
    prov = Provider.of<ActivityDetailProvider>(context, listen: false);

    // _fetchActOwned(widget.actOwnedId);
    // actOwned = widget.actOwned;
    _fetchActOwned(widget.actOwnedId);

    _fetchActivityDetails(widget.act);
  }

  @override
  Widget build(BuildContext context) {
    prov = context.watch<ActivityDetailProvider>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ORANGE_GARUDA,
          foregroundColor: Colors.black,
          // title: Text(actOwned.activity.activity_name)),
          title: Text(widget.title)),
      body: (prov.isFetchingActOwned)
          ? LoadingWidget()
          : SingleChildScrollView(
              child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
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
                              text: actOwned.activity.activity_description,
                              // text: 'dafi'
                            ),
                            (prov.isFetchingActDetails)
                                ? CircularProgressIndicator()
                                : (actDetails.isEmpty)
                                    ? Container()
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: actDetails.length,
                                        itemBuilder: (context, i) {
                                          return Align(
                                            alignment: Alignment.center,
                                            child: ActivityDetailWidget(
                                              detail: actDetails[i],
                                            ),
                                          );
                                        }),
                          ],
                        ),
                      ),
                    ),
                    Space.doubleSpace(),
                    ElevatedButton(
                      onPressed: (prov.isButtonDisabled)
                          ? () {}
                          : () {
                              _editActivityStatus('submitted');
                            },
                      child: Text('Mark As Done'),
                      style: ElevatedButton.styleFrom(
                          primary: (prov.isButtonDisabled)
                              ? Colors.blue[200]
                              : Colors.blue),
                    ),
                  ],
                ),
              ),
            )),
    );
  }

  void refresh() async {
    setState(() {
      _fetchActOwned(widget.actOwnedId);
    });
  }

  void _getStatus(ActivityOwned actOwned) {
    if (actOwned.status == 'submitted' || actOwned.status == 'completed') {
      prov.isButtonDisabled = true;
    } else {
      prov.isButtonDisabled = false;
    }
  }

  void _error(e) async {
    return showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(error: e.toString(), title: "HTTP Error");
        });
  }

  void _fetchActOwned(int id) async {
    prov.isFetchingActOwned = true;

    try {
      actOwned = await prov.fetchActOwnedById(id);
      _getStatus(actOwned);
      prov.isFetchingActOwned = false;
    } catch (e) {
      prov.isFetchingActOwned = false;
      return _error(e);
    }
  }

  void errorFetchingActivityDetails(e) async {
    actDetails = [];
    return showDialog(
        context: context,
        builder: (context) {
          return ErrorAlertDialog(error: 'HTTP Error', title: e.toString());
        });
  }

  void _fetchActivityDetails(Activity act) async {
    prov.isFetchingActDetails = true;

    try {
      actDetails = await prov.fetchDetailsByActivityId(act);
      prov.isFetchingActDetails = false;
    } catch (e) {
      prov.isFetchingActDetails = false;
      return errorFetchingActivityDetails(e);
    }
  }

  void _editActivityStatus(String status) async {
    prov.isFetchingActDetails = true;

    try {
      await prov.editActivityStatus(widget.actOwnedId, status);
      refresh();
      prov.isFetchingActDetails = false;
    } catch (e) {
      prov.isFetchingActDetails = false;
      return errorFetchingActivityDetails(e);
    }
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
  late ActivityDetailProvider prov;
  bool isChecked = false;

  int currPlayIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    prov = context.watch<ActivityDetailProvider>();
    if (widget.detail == null) {
      return _getDeskripsi();
    }
    return _getDetailContent();
  }

  _getDetailContent() {
    if (widget.detail!.detail_type == 'header') {
      return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          widget.detail!.detail_desc,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    } else if (widget.detail!.detail_type == 'text') {
      return Container(
        alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(bottom: 10),
          child: Text(widget.detail!.detail_desc));
    } else if (widget.detail!.detail_type == 'to_do') {
      return Row(
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
      );
    } else if (widget.detail!.detail_type == 'image') {
      return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: getImage(widget.detail!.detail_link!));
    } else if (widget.detail!.detail_type == 'video') {
      return Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 10),
          child: DetailVideoPlayer(
            link: widget.detail!.detail_link!,
          ));
    } else if (widget.detail!.detail_type == 'video_link') {
      return Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(bottom: 10),
          child: MyYoutubePlayer(
            link: widget.detail!.detail_name,
          ));
    } else if (widget.detail!.detail_type == 'pdf') {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: DetailPdf(
          fileName: widget.detail!.detail_name,
          fileLink: widget.detail!.detail_link!,
        ),
      );
    }
    return Container();
  }

  Widget getImage(String link) {
    return CachedNetworkImage(
        imageUrl: BASE_URL + '/' + link,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Text('image not found'));
  }

  Container _getDeskripsi() {
    if (widget.type == 'header') {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
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
