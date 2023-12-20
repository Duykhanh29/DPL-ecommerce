// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoNetworkItemWidget extends StatefulWidget {
  String filePath;
  VideoNetworkItemWidget({
    Key? key,
    required this.filePath,
  }) : super(key: key);
  @override
  _VideoNetworkItemWidgetState createState() => _VideoNetworkItemWidgetState();
}

class _VideoNetworkItemWidgetState extends State<VideoNetworkItemWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.filePath));

    // Khởi tạo video player
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
      padding: EdgeInsets.all(4.h),
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.height * 0.12,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     setState(() {
    //       if (_controller.value.isPlaying) {
    //         _controller.pause();
    //       } else {
    //         _controller.play();
    //       }
    //     });
    //   },
    //   child: Icon(
    //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,

    // );
  }
}
