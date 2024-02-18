import 'package:cached_network_image/cached_network_image.dart';
import 'package:dpl_ecommerce/helpers/date_helper.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/repositories/auth_repo.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/repositories/shop_repo.dart';
import 'package:dpl_ecommerce/repositories/user_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/screens/chatting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dpl_ecommerce/utils/constants/image_data.dart';

class ChatItem extends StatefulWidget {
  ChatItem({super.key, required this.chat});
  // UserModel userModel = AuthRepo().user;
  Chat? chat;

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  ChatRepo chatRepo = ChatRepo();
  UserRepo userRepo = UserRepo();
  ShopRepo shopRepo = ShopRepo();
  String? avatar;
  String? name;
  UserModel? user;
  Shop? shop;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // if (widget.chat!.userID == widget.uid) {
    //   user = await userRepo.getUserByID(widget.chat!.sellerID!);
    //   if (user != null) {
    //     name = user!.firstName;
    //     avatar = user!.avatar;
    //   }
    // } else {
    // user = await userRepo.getUserByID(widget.chat!.userID!);
    shop = await shopRepo.getShopByID(widget.chat!.shopID!);
    if (shop != null) {
      name = shop!.name;
      avatar = shop!.logo;
    }
    // }
    if (mounted) {
      setState(() {});
    }
  }

  Text showName(Chat chatData) {
    if (name != null) {
      return Text(name!);
    }
    return const Text("...");
    // if (widget.currentUser.id == widget.chat!.userID) {
    //   return Text(chatData.shopName!);
    // }
    // return Text(chatData.userName!);
  }

  Text showLastMsg() {
    if (widget.chat!.listMsg!.last.productID != null) {
      return const Text("Product detail");
    }
    if (widget.chat!.lastChatType == ChatType.image) {
      return const Text("An image is sent");
    } else if (widget.chat!.lastChatType == ChatType.video) {
      return const Text("A video is sent");
    } else if (widget.chat!.lastChatType == ChatType.link) {
      return const Text("A link is sent");
    }
    return Text(widget.chat!.lastMessage!);
  }

  String? getAvatar(Chat chatData) {
    // if (widget.currentUser.id == chatData.userID) {
    //   return chatData.shopLogo!;
    // }
    // return chatData.userAvatar!;
    if (avatar != null) {
      return avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: true);
    final size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;

    return Container(
        constraints: BoxConstraints(maxHeight: size.height * 0.1),
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 135, 177, 254)),
        // margin: const EdgeInsets.only(top: 5),
        child: StreamBuilder(
          stream: chatRepo.getChatDataByID(widget.chat!.id!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListTile();
            } else {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  final chat = snapshot.data;
                  final url;
                  if (user!.id == chat!.userID) {
                    url = chat.shopLogo;
                  } else {
                    url = chat.userAvatar;
                  }
                  return ListTile(
                      onTap: () {
                        // go to chattingPage
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return ChattingPage(
                              chat: chat,
                            );
                          },
                        ));
                      },
                      leading: avatar != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(getAvatar(chat)!),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  AssetImage(ImageData.circelAvatar),
                            ),
                      title: showName(chat),
                      subtitle: buildSubtitle(chat, context),
                      trailing: Text(DateHelper.chatTime(
                          chat.listMsg!.last.time!.toDate())));
                }
              }
            }
            return Center(
              child: Text(
                  LangText(context: context).getLocal()!.no_data_is_available),
            );
          },
        ));
  }

  Widget buildTimeItem() {
    return StreamBuilder(
      stream: chatRepo.getChatDataByID(widget.chat!.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final chatData = snapshot.data;
              return Text(
                  DateHelper.chatTime(chatData!.listMsg!.last.time!.toDate()));
            }
          }
        }
        return Center(
          child: Text(""),
        );
      },
    );
  }

  Widget buildSubtitle(Chat chat, BuildContext context) {
    if (chat.listMsg!.last.productID != null) {
      return Text(LangText(context: context).getLocal()!.product_detail_ucf);
    }
    if (chat.lastChatType == ChatType.image) {
      return Text(LangText(context: context).getLocal()!.a_image_is_send);
    } else if (chat.lastChatType == ChatType.video) {
      return Text(LangText(context: context).getLocal()!.a_video_is_send);
    } else if (chat.lastChatType == ChatType.link) {
      return Text(LangText(context: context).getLocal()!.a_link_is_send);
    } else {
      return Text(chat.listMsg!.last.content!);
    }
  }
}
