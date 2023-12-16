import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/chat/list_seller_chat.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => __ChatListState();
}

class __ChatListState extends State<ChatList> {
  List<Chat> listChat = ChatRepo().list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat list'),
      ),
      body: ListSellerChat(),
    );
  }
}
