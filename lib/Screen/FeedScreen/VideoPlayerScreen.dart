import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../values/Colors.dart';

class VideoPlayerScreen extends StatefulWidget {
  String? video_urle;
  VideoPlayerScreen({Key? key, this.video_urle}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  late YoutubePlayerController _controllerr;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    print("dixit=======url===" + widget.video_urle!);
    _controller = VideoPlayerController.network(
      '' + widget.video_urle!,
    );
    _initializeVideoPlayerFuture = _controller!.initialize();

    _controller!.setLooping(true);

    String? videoId;
    videoId = YoutubePlayer.convertUrlToId("" + widget.video_urle!);
    print(videoId);

    _controllerr = YoutubePlayerController(
      initialVideoId: "" + videoId!,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );

    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    super.initState();
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controllerr.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controllerr.dispose();
    _controller!.dispose();
    super.dispose();
  }

  videoRotation() async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      body: Center(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();

            return await videoRotation();
          },
          child: YoutubePlayer(
            controller: _controllerr,
            showVideoProgressIndicator: true,


            // },
          ),
        ),
      ),

    );
  }
}
