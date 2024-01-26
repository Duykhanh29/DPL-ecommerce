import 'package:dpl_ecommerce/const/app_theme.dart';
import 'package:dpl_ecommerce/customs/custom_array_back_widget.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/repositories/chat_repo.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  List<Chat> listChat = ChatRepo().list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyTheme.accent_color,
        leading: CustomArrayBackWidget(),
        title: Text(
          AppLocalizations.of(context)!.chat_list,
          style: TextStyle(color: MyTheme.white),
        ),
      ),
      body: ListChat(),
    );
  }
}
