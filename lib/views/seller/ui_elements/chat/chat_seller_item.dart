import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatSellerItem extends StatelessWidget {
  ChatSellerItem({super.key, required this.chat});
  UserModel userModel = AuthRepo().user;
  Chat? chat;
  Text showName() {
    if (userModel.id == chat!.userID) {
      return Text(chat!.shopName!);
    }
    return Text(chat!.userName!);
  }

  Text showLastMsg() {
    if (chat!.listMsg!.last.productID != null) {
      return const Text("Product detail");
    }
    if (chat!.lastChatType == ChatType.image) {
      return const Text("An image is sent");
    } else if (chat!.lastChatType == ChatType.video) {
      return const Text("A video is sent");
    } else if (chat!.lastChatType == ChatType.link) {
      return const Text("A link is sent");
    }
    return Text(chat!.lastMessage!);
  }

  String getAvatar() {
    if (userModel.id == chat!.userID) {
      return chat!.shopLogo!;
    }
    return chat!.userAvatar!;
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: true);
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(maxHeight: size.height * 0.1),
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 135, 177, 254)),
      // margin: const EdgeInsets.only(top: 5),
      child: ListTile(
        onTap: () {
          // go to chattingPage
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return ChattingPage(
                chat: chat,
                isShop: true,
              );
            },
          ));
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(getAvatar()),
        ),
        title: showName(),
        subtitle: Consumer<ChatViewModel>(
          builder: (context, value, child) {
            if (chat!.listMsg!.last.productID != null) {
              return const Text("Product detail");
            }
            if (chat!.lastChatType == ChatType.image) {
              return const Text("An image is sent");
            } else if (chat!.lastChatType == ChatType.video) {
              return const Text("A video is sent");
            } else if (chat!.lastChatType == ChatType.link) {
              return const Text("A link is sent");
            }
            return Text(chat!.lastMessage!);
          },
        ),
        trailing: Consumer<ChatViewModel>(
          builder: (context, value, child) {
            return Text(
                DateHelper.chatTime(chat!.listMsg!.last.time!.toDate()));
          },
        ),
      ),
    );
  }
}
