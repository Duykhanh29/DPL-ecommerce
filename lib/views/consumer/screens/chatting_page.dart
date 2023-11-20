import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/list_msg.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';

class ChattingPage extends StatelessWidget {
  ChattingPage({super.key, required this.chat});
  Chat? chat;
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
                );
              },
            ),
          ),
          // Spacer(),
          Inputter(chat: chat),
        ],
      ),
    );
  }
}

class Inputter extends StatefulWidget {
  Inputter({super.key, required this.chat});
  Chat? chat;

  @override
  State<Inputter> createState() => _InputterState();
}

class _InputterState extends State<Inputter> {
  TextEditingController controller = TextEditingController();
  UserModel userModel = AuthRepo().user;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  void _showPicker(BuildContext context) {
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
                    final path = result.files.single.path;
                    final fileName = result.files.single.name;
                    String type = '';
                    late ChatType chatType;
                    if (fileName.contains('.mp4')) {
                      type = 'videos';
                      chatType = ChatType.video;
                    } else if (fileName.contains('.png') ||
                        fileName.contains('.jpg')) {
                      type = 'images';
                      chatType = ChatType.video;
                    }
                    // Message msg = Message(chatType: chatType,content: );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Camera"),
                onTap: () {},
              ),
            ],
          ));
        });
  }

  void sendMsg(String text, ChatViewModel chatProvider) {
    Message message = Message(
        chatType: ChatType.text,
        content: text,
        isShop: false,
        senderID: userModel.id,
        time: DateTime.now(),
        receiverID: widget.chat!.sellerID);
    chatProvider.sendMsgToAChatBox(message, widget.chat!.id!);
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context);
    return Row(
      children: [
        const SizedBox(
          width: 10,
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
                      _showPicker(context);
                    },
                    icon: const Icon(Icons.photo))),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () {
              if (controller.text != null || controller.text != "") {
                sendMsg(controller.text, chatProvider);
                controller.text = "";
              }
            },
            child: Icon(Icons.send),
          ),
        )
      ],
    );
  }
}
