// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class VideoLocalItemWidget extends StatefulWidget {
  String filePath;
  double? width;
  double? height;
  VideoLocalItemWidget(
      {Key? key, required this.filePath, this.height, this.width})
      : super(key: key);
  @override
  _VideoLocalItemWidgetState createState() => _VideoLocalItemWidgetState();
}

class _VideoLocalItemWidgetState extends State<VideoLocalItemWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Duration position = Duration.zero;
  bool isPlayed = false;
  @override
  void initState() {
    // Đường dẫn tới tệp video MP4
    // String videoPath = "path/to/your/video.mp4";

    // Tạo VideoPlayerController
    _controller = VideoPlayerController.asset(widget.filePath)
      ..addListener(() => setState(() {
            position = _controller.value.position;
          }))
      ..setLooping(false)
      ..initialize().then((value) {
        if (isPlayed) {
          _controller.play();
        }
      });
    ;

    // Khởi tạo video player
    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void playVideo() {
    setState(() {
      if (_controller.value.isInitialized) {
        _controller.seekTo(position);
      }
      _controller.play();
      isPlayed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.yellow)),
      padding: EdgeInsets.all(4.h),
      height: widget.height ?? MediaQuery.of(context).size.height * 0.12,
      width: widget.width ?? MediaQuery.of(context).size.height * 0.12,
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  Positioned.fill(
                      child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _controller.value.isPlaying
                        ? _controller.pause()
                        : playVideo(),
                    child: Stack(
                      children: <Widget>[
                        _controller.value.isPlaying
                            ? Container()
                            : Container(
                                alignment: Alignment.center,
                                color: Colors.black26,
                                child: const Icon(Icons.play_arrow,
                                    color: Colors.white, size: 40),
                              ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VideoProgressIndicator(
                            _controller,
                            allowScrubbing: false,
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
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
