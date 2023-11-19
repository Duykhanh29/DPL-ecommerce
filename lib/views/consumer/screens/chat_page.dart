import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/list_chat.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  List<Chat> listChat = ChatRepo().list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomArrayBackWidget(),
        title: Text("Chats"),
      ),
      body: ListChat(),
    );
  }
}
