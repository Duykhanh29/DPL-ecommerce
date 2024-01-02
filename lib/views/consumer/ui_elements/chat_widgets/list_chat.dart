import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:dpl_ecommerce/view_model/consumer/chat_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListChat extends StatefulWidget {
  ListChat({super.key});

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  ChatRepo chatRepo = ChatRepo();

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatViewModel>(context, listen: true);
    final userProvider = Provider.of<UserViewModel>(context);
    final user = userProvider.currentUser;
    return StreamBuilder(
      stream: chatRepo.getAllChatByUser(user!.id!),
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
                    child: ChatItem(
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
    // Consumer<ChatViewModel>(builder: (context, value, child) {
    //   var listChat = chatProvider.list;
    //   return
    // });
  }
}
