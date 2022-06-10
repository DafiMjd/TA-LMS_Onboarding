// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/models/activity.dart';
import 'package:lms_onboarding/models/activity_detail.dart';
import 'package:lms_onboarding/providers/home/home_activity_detail_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/utils/custom_colors.dart';
import 'package:lms_onboarding/views/activity/widgets/detail_pdf.dart';
import 'package:lms_onboarding/views/activity/widgets/detail_video_player.dart';
import 'package:lms_onboarding/widgets/error_alert_dialog.dart';
import 'package:provider/provider.dart';

class HomeActivityDetailPage extends StatefulWidget {
  const HomeActivityDetailPage({Key? key, required this.act}) : super(key: key);

  final Activity act;

  @override
  State<HomeActivityDetailPage> createState() => _HomeActivityDetailPageState();
}

class _HomeActivityDetailPageState extends State<HomeActivityDetailPage> {
  late List<ActivityDetail> actDetails;
  late HomeActivityDetailProvider prov;

  @override
  void initState() {
    super.initState();

    prov = Provider.of<HomeActivityDetailProvider>(context, listen: false);

    _fetchActivityDetails(widget.act);
  }

  void _error(e) async {
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
      return _error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    prov = context.watch<HomeActivityDetailProvider>();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ORANGE_GARUDA,
          foregroundColor: Colors.black,
          // title: Text(actOwned.activity.activity_name)),
          title: Text(widget.act.activity_name)),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeActivityDetailWidget(
                      type: 'header',
                      text: 'Deskripsi',
                    ),
                    HomeActivityDetailWidget(
                      type: 'text',
                      text: widget.act.activity_description,
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
                                  return HomeActivityDetailWidget(
                                    detail: actDetails[i],
                                  );
                                }),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class HomeActivityDetailWidget extends StatefulWidget {
  const HomeActivityDetailWidget({Key? key, this.detail, this.type, this.text})
      : super(key: key);

  final ActivityDetail? detail;
  final String? type;
  final String? text;

  @override
  State<HomeActivityDetailWidget> createState() =>
      _HomeActivityDetailWidgetState();
}

class _HomeActivityDetailWidgetState extends State<HomeActivityDetailWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    if (widget.detail == null) {
      return _getDeskripsi();
    }
    return _getDetailContent();
  }

  _getDetailContent() {
    if (widget.detail!.detail_type == 'header') {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
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

  // _getDetailContent() {
  //   if (widget.detail!.detail_type == 'header') {
  //     return Container(
  //       margin: EdgeInsets.only(bottom: 10),
  //       child: Text(
  //         widget.detail!.detail_desc,
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //     );
  //   } else if (widget.detail!.detail_type == 'text') {
  //     return Container(
  //         margin: EdgeInsets.only(bottom: 10),
  //         child: Text(widget.detail!.detail_desc));
  //   } else if (widget.detail!.detail_type == 'to_do') {
  //     return Container(
  //       // margin: EdgeInsets.only(bottom: 5),
  //       child: Row(
  //         children: [
  //           Checkbox(
  //             checkColor: Colors.white,
  //             fillColor: MaterialStateProperty.resolveWith(getColor),
  //             value: isChecked,
  //             onChanged: (bool? value) {
  //               setState(() {
  //                 isChecked = value!;
  //               });
  //             },
  //           ),
  //           Text(widget.detail!.detail_desc),
  //         ],
  //       ),
  //     );
  //   }
  //   return Container();
  // }

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
