import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:quickie_event/Constant.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset("assets/vid/video.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
    );
  }

  int datetime = DateTime.now().millisecondsSinceEpoch;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Chewie(controller: _chewieController)],
        ),
      ),
    );
  }
}
