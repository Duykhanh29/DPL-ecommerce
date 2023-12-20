import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/services/storage_services/storage_service.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/media_preview.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/list_msg.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';

class ChattingPage extends StatelessWidget {
  ChattingPage(
      {super.key, required this.chat, this.isShop = false, this.isNew = false});
  bool isShop;
  Chat? chat;
  bool isNew;
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: const Text("Chatting page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Consumer<ChatViewModel>(
              builder: (context, value, child) {
                return ListMsg(
                  list: chat!.listMsg ?? [],
                  chat: chat,
                  isShop: isShop,
                );
              },
            ),
          ),
          // Spacer(),
          Inputter(chat: chat, isShop: isShop),
        ],
      ),
    );
  }
}

class Inputter extends StatefulWidget {
  Inputter({super.key, required this.chat, this.isShop = false});
  Chat? chat;
  bool isShop;
  @override
  State<Inputter> createState() => _InputterState();
}

class _InputterState extends State<Inputter> {
  TextEditingController controller = TextEditingController();
  UserModel userModel = AuthRepo().user;
  StorageService storageService = StorageService();
  ChatRepo chatRepo = ChatRepo();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  String? urlMedia;
  void _showPicker(
      {required BuildContext context,
      required String senderID,
      required String receiverID}) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png', 'jpg', 'mp4']);
                  if (result != null) {
                    // final path = result.files.single.path;
                    // final fileName = result.files.single.name;
                    // String type = '';
                    // late ChatType chatType;
                    // if (fileName.contains('.mp4')) {
                    //   type = 'videos';
                    //   chatType = ChatType.video;
                    // } else if (fileName.contains('.png') ||
                    //     fileName.contains('.jpg')) {
                    //   type = 'images';
                    //   chatType = ChatType.video;
                    // }
                    // fdsf
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return MediaPreviewScreen(
                            file: result.files.single,
                            chatID: widget.chat!.id,
                            receiverID: receiverID,
                            senderID: senderID);
                      },
                    ));
                  }
                },
              ),
              // ListTile(
              //   leading: const Icon(Icons.photo_library),
              //   title: const Text("Camera"),
              //   onTap: () {},
              // ),
            ],
          ));
        });
  }

  void sendMsg(String text, ChatViewModel chatProvider) {
    Message message = Message(
        chatType: ChatType.text,
        content: text,
        isShop: widget.isShop,
        senderID: userModel.id,
        time: Timestamp.fromDate(DateTime.now()),
        receiverID:
            !widget.isShop ? widget.chat!.sellerID : widget.chat!.userID);
    chatProvider.sendMsgToAChatBox(message, widget.chat!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context);
    final userProvider = Provider.of<UserViewModel>(context);
    final currentUser = userProvider.currentUser;
    String senderID;
    String receiverID;
    if (currentUser!.id == widget.chat!.userID) {
      senderID = widget.chat!.userID!;
      receiverID = widget.chat!.sellerID!;
    } else {
      receiverID = widget.chat!.userID!;
      senderID = widget.chat!.sellerID!;
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              flex: 6,
              child: TextField(
                controller: controller,
                focusNode: FocusNode(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: IconButton(
                        onPressed: () async {
                          _showPicker(
                              context: context,
                              receiverID: receiverID,
                              senderID: senderID);
                        },
                        icon: const Icon(Icons.photo))),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  if (controller.text != null || controller.text != "") {
                    sendMsg(controller.text, chatProvider);
                    controller.text = "";
                    Message msg = Message(
                      chatType: ChatType.text,
                      content: controller.text,
                      isShop: widget.isShop,
                      time: Timestamp.now(),
                      receiverID: widget.isShop
                          ? widget.chat!.userID
                          : widget.chat!.sellerID,
                      senderID: currentUser.id,
                    );
                    await chatRepo.sendAMessage(
                        chatID: widget.chat!.id!, msg: msg);
                  }
                },
                child: Icon(Icons.send),
              ),
            )
          ],
        ),
      ),
    );
  }
}
