// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoLocalItemWidget extends StatefulWidget {
  String filePath;
  VideoLocalItemWidget({
    Key? key,
    required this.filePath,
  }) : super(key: key);
  @override
  _VideoLocalItemWidgetState createState() => _VideoLocalItemWidgetState();
}

class _VideoLocalItemWidgetState extends State<VideoLocalItemWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Đường dẫn tới tệp video MP4
    // String videoPath = "path/to/your/video.mp4";

    // Tạo VideoPlayerController
    _controller = VideoPlayerController.asset(widget.filePath);

    // Khởi tạo video player
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.h),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Khi video đã được khởi tạo, hiển thị video
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            // Hiển thị loading indicator trong khi khởi tạo video
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () {
    //     // Xử lý sự kiện khi nhấn vào nút play/pause
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

  @override
  void dispose() {
    // Hủy bỏ video controller khi widget bị dispose
    _controller.dispose();
    super.dispose();
  }
}
