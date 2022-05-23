import 'package:auto_orientation/auto_orientation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:lms_onboarding/providers/leaderboard/leaderboard_provider.dart';
import 'package:lms_onboarding/utils/constans.dart';
import 'package:lms_onboarding/views/bottom_navbar.dart';
import 'package:lms_onboarding/views/leaderboard/leaderboard_page.dart';
import 'package:lms_onboarding/widgets/space.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoTest extends StatefulWidget {
  const VideoTest({Key? key}) : super(key: key);

  @override
  State<VideoTest> createState() => _VideoTestState();
}

class _VideoTestState extends State<VideoTest> {
  // TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();

  }

  List<String> srcs = [
    "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4",
    "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4"
  ];

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(
        BASE_URL + '/api/ShowVideo/intro pendek.mp4');
    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    _createChewieController();
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    // final subtitles = [
    //   Subtitle(
    //     index: 0,
    //     start: Duration.zero,
    //     end: const Duration(seconds: 10),
    //     text: const TextSpan(
    //       children: [
    //         TextSpan(
    //           text: 'Hello',
    //           style: TextStyle(color: Colors.red, fontSize: 22),
    //         ),
    //         TextSpan(
    //           text: ' from ',
    //           style: TextStyle(color: Colors.green, fontSize: 20),
    //         ),
    //         TextSpan(
    //           text: 'subtitles',
    //           style: TextStyle(color: Colors.blue, fontSize: 18),
    //         )
    //       ],
    //     ),
    //   ),
    //   Subtitle(
    //     index: 0,
    //     start: const Duration(seconds: 10),
    //     end: const Duration(seconds: 20),
    //     text: 'Whats up? :)',
    //     // text: const TextSpan(
    //     //   text: 'Whats up? :)',
    //     //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
    //     // ),
    //   ),
    // ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,

      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: toggleVideo,
            iconData: Icons.live_tv_sharp,
            title: 'Toggle Video Src',
          ),
        ];
      },

      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  int currPlayIndex = 0;

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    currPlayIndex = currPlayIndex == 0 ? 1 : 0;
    await initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          ),
          Container(),
          // TextButton(
          //   onPressed: () {
          //     _chewieController?.enterFullScreen();
          //     AutoOrientation.portraitUpMode();
          //   },
          //   child: const Text('Fullscreen'),
          // ),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text('Orientation'),
          // ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () {
          //           setState(() {
          //             _videoPlayerController1.pause();
          //             _videoPlayerController1.seekTo(Duration.zero);
          //             _createChewieController();
          //           });
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16.0),
          //           child: Text("Landscape Video"),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () {
          //           // setState(() {
          //           //   _platform = TargetPlatform.android;
          //           // });
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16.0),
          //           child: Text("Android controls"),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () {
          //           // setState(() {
          //           //   _platform = TargetPlatform.iOS;
          //           // });
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16.0),
          //           child: Text("iOS controls"),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // Row(
          //   children: <Widget>[
          //     Expanded(
          //       child: TextButton(
          //         onPressed: () {
          //           // setState(() {
          //           //   _platform = TargetPlatform.windows;
          //           // });
          //         },
          //         child: const Padding(
          //           padding: EdgeInsets.symmetric(vertical: 16.0),
          //           child: Text("Desktop controls"),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
