import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/video_item_widget.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/video_asset_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MediaPreviewScreen extends StatelessWidget {
  MediaPreviewScreen(
      {super.key,
      required this.file,
      required this.chatID,
      this.isShop = false,
      required this.receiverID,
      required this.senderID});
  PlatformFile file;
  String? chatID;
  bool isShop;
  String senderID;
  String receiverID;
  StorageService storageService = StorageService();
  ChatRepo chatRepo = ChatRepo();
  String showTitle(BuildContext context, String fileName) {
    return fileName.contains('.mp4') ? "Preview video" : "Preview image";
  }

  bool isImage(String fileName) {
    return fileName.contains('.mp4') ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: Text(isImage(file.name)
            ? LangText(context: context).getLocal()!.preview_image
            : LangText(context: context).getLocal()!.preview_video),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.w),
        child: Container(
          // decoration: BoxDecoration(color: Colors.red),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: isImage(file.name)
                      ? Image.file(
                          File(file.path!),
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.9,
                          fit: BoxFit.contain,
                        )
                      : VideoLocalItemWidget(
                          filePath: file.path!,
                          height: MediaQuery.of(context).size.height * 0.85,
                          width: MediaQuery.of(context).size.width * 0.9,
                        ),
                ),
                // const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () async {
                      late ChatType chatType;
                      String type = '';
                      if (file.path!.contains('.mp4')) {
                        type = 'videos';
                        chatType = ChatType.video;
                      } else if (file.path!.contains('.png') ||
                          file.path!.contains('.jpg')) {
                        type = 'images';
                        chatType = ChatType.image;
                      }
                      bool isSuccess = await storageService.uploadFile(
                          filePath: file.path!,
                          fileName: file.name,
                          secondRef: chatID,
                          rootRef: 'chats',
                          thirdRef: type);
                      if (isSuccess) {
                        String urlMedia = await storageService.downloadURL(
                            filePath: file.path!,
                            fileName: file.name,
                            secondRef: chatID,
                            rootRef: 'chats',
                            thirdRef: type);
                        Message msg = Message(
                            chatType: chatType,
                            content: urlMedia,
                            isShop: isShop,
                            time: Timestamp.now(),
                            senderID: senderID,
                            receiverID: receiverID);
                        if (chatID == null) {
                          Chat c = Chat(
                            lastChatType: chatType,
                            lastMessage: urlMedia,
                            listMsg: [msg],
                            sellerID: isShop ? senderID : receiverID,
                            // shopID: ,
                            // shopLogo: ,
                            // userName: ,
                            // shopName: ,
                            // userAvatar: ,
                            userID: isShop ? receiverID : senderID,
                          );
                          await chatRepo.addNewChat(c);
                        } else {
                          await chatRepo.sendAMessage(
                              chatID: chatID!, msg: msg);
                        }

                        // ignore: use_build_context_synchronously
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                        //     await chatRepo.
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.grey.shade300),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            size: 30.h,
                            color: Colors.blue,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
