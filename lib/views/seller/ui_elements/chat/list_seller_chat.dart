import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/chat_item.dart';
import 'package:dpl_ecommerce/views/seller/ui_elements/chat/chat_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListSellerChat extends StatelessWidget {
  ListSellerChat({super.key});
  ChatRepo chatRepo = ChatRepo();
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: true);
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return
        //  Consumer<ChatViewModel>(builder: (context, value, child) {
        //   var listChat = chatProvider.list;
        //   return ListView.builder(
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
        //         child: ChatSellerItem(
        //           chat: listChat[index],
        //         ),
        //       );
        //     },
        //     itemCount: listChat.length,
        //   );
        // });
        StreamBuilder(
      stream: chatRepo.getAllChatBySellerID(user!.id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              final list = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    child: ChatSellerItem(
                      chat: list[index],
                    ),
                  );
                },
                itemCount: list!.length,
              );
            }
          }
        }
        return Center(
          child:
              Text(LangText(context: context).getLocal()!.no_data_is_available),
        );
      },
    );
  }
}
