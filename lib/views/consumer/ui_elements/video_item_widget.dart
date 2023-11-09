import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItemWidget extends StatefulWidget {
  VideoItemWidget({super.key, required this.videoUrl});
  String? videoUrl;

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlayed = false;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"))
      ..addListener(() {
        setState(() {
          position = videoPlayerController.value.position;
        });
      })
      ..setLooping(false)
      ..initialize().then((value) {
        if (isPlayed) {
          videoPlayerController.play();
        }
      });
  }

  void playVideo() {
    setState(() {
      if (videoPlayerController.value.isInitialized) {
        videoPlayerController.seekTo(position);
      }
      videoPlayerController.play();
      isPlayed = true;
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController != null &&
            videoPlayerController.value.isInitialized
        ? Container(
            padding: EdgeInsets.only(right: 5, left: 5, top: 5),
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: VideoPlayer(videoPlayerController),
                ),
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      videoPlayerController.value.isPlaying
                          ? videoPlayerController.pause()
                          : playVideo();
                    },
                    child: Stack(
                      children: [
                        videoPlayerController.value.isPlaying
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
                            videoPlayerController,
                            allowScrubbing: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.indigo, width: 1)),
            width: MediaQuery.of(context).size.width * 0.6,
            height: 160,
            child: const Center(child: CircularProgressIndicator()),
          );
  }
}
