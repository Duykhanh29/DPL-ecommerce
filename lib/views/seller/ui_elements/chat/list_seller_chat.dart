import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/chat_item.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/chat/chat_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSellerChat extends StatelessWidget {
  ListSellerChat({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: true);

    return Consumer<ChatViewModel>(builder: (context, value, child) {
      var listChat = chatProvider.list;
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
            child: ChatSellerItem(
              chat: listChat[index],
            ),
          );
        },
        itemCount: listChat.length,
      );
    });
  }
}
