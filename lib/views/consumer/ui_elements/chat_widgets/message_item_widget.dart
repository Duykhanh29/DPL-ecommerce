import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/customs/custom_image_view.dart';
import 'package:dpl_ecommerce/customs/custom_photo_view.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/link_msg.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/msg_with_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
import 'package:video_player/video_player.dart';

class MessageItemWidget extends StatelessWidget {
  MessageItemWidget(
      {super.key,
      required this.message,
      required this.chat,
      this.isShop = false});
  Chat? chat;
  Message? message;
  bool isShop;
  UserModel userModel = AuthRepo().user;
  Widget _buildMsg() {
    if (message!.chatType == ChatType.image) {
      return ImageWidget(
        chat: chat,
        message: message,
      );
    } else if (message!.chatType == ChatType.video) {
      return VideoMsg(
        chat: chat,
        message: message,
      );
    } else if (message!.chatType == ChatType.link) {
      return LinkMsg(
        chat: chat,
        message: message,
      );
    } else {
      return TextMsg(message: message, chat: chat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: message!.productID != null
          ? MsgWithProduct(
              productID: message!.productID,
            )
          : Row(
              mainAxisAlignment: (message!.senderID == userModel.id &&
                      (userModel.userInfor!.sellerInfor == null ||
                          !userModel.userInfor!.sellerInfor!.shopIDs!
                              .contains(chat!.shopID)))
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if ((message!.senderID != userModel.id)) ...{
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.height / 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(!isShop
                              ? (chat!.shopLogo ??
                                  "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")
                              : (chat!.userAvatar ??
                                  "https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png")),
                        ),
                      ),
                    ],
                  ),
                },
                _buildMsg()
              ],
            ),
    );
  }
}

class TextMsg extends StatelessWidget {
  TextMsg({super.key, required this.message, required this.chat});
  Message? message;
  UserModel userModel = AuthRepo().user;
  Chat? chat;

  @override
  Widget build(BuildContext context) {
    return ChatBubble(
      clipper: ChatBubbleClipper6(
          type: (message!.senderID == userModel.id &&
                  (userModel.userInfor!.sellerInfor == null ||
                      !userModel.userInfor!.sellerInfor!.shopIDs!
                          .contains(chat!.shopID)))
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
      backGroundColor: Colors.blue,
      child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
              minHeight: MediaQuery.of(context).size.height * 0.05),
          child: FittedBox(
              child: Column(children: [
            Text(message!.content ?? ""),
            Text(
              DateHelper.chatTime(message!.time!.toDate()),
              style: TextStyle(fontSize: 10),
            )
          ]))),
    );
  }
}

class ImageWidget extends StatelessWidget {
  ImageWidget({super.key, required this.message, required this.chat});
  Message? message;
  UserModel userModel = AuthRepo().user;
  Chat? chat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChatBubble(
      clipper: ChatBubbleClipper6(
          type: (message!.senderID == userModel.id &&
                  (userModel.userInfor!.sellerInfor == null ||
                      !userModel.userInfor!.sellerInfor!.shopIDs!
                          .contains(chat!.shopID)))
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
      backGroundColor: Colors.white,
      child: Container(
        // padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        leading: CustomArrayBackWidget(),
                      ),
                      body: CustomPhotoView(urlImage: message!.content),
                    );
                  },
                ));
              },
              // child: SizedBox(
              //   height: size.height * 0.15,
              //   width: size.width * 0.6,
              child: Image.network(
                message!.content!,
                height: size.height * 0.2,
                width: size.width * 0.6,
              ),
              // ),
            ),
            Text(DateHelper.chatTime(message!.time!.toDate()))
          ],
        ),
      ),
    );
  }
}

class VideoMsg extends StatefulWidget {
  VideoMsg({super.key, required this.message, required this.chat});
  Message? message;
  Chat? chat;

  @override
  State<VideoMsg> createState() => _VideoMsgState();
}

class _VideoMsgState extends State<VideoMsg> {
  UserModel userModel = AuthRepo().user;
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  bool isPlayed = false;
  Duration position = Duration.zero;
  // UserModel userModel = AuthRepo().user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
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
    } catch (e) {
      print("Error: $e");
    }
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
    final size = MediaQuery.of(context).size;
    return ChatBubble(
        clipper: ChatBubbleClipper6(
            type: (widget.message!.senderID == userModel.id &&
                    (userModel.userInfor!.sellerInfor == null ||
                        !userModel.userInfor!.sellerInfor!.shopIDs!
                            .contains(widget.chat!.shopID)))
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble),
        backGroundColor: Colors.white,
        child: Column(
          children: [
            videoPlayerController != null &&
                    videoPlayerController.value.isInitialized
                ? Container(
                    height: size.height * 0.2,
                    width: size.width * 0.6,
                    padding: EdgeInsets.only(right: 5, left: 5, top: 5),
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 9 / 6,
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
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
            Text(DateHelper.chatTime(widget.message!.time!.toDate()))
          ],
        ));
  }
}
