import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/views/consumer/ui_elements/chat_widgets/message_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ListMsg extends StatelessWidget {
  ListMsg(
      {super.key, required this.list, required this.chat, this.isShop = false});
  List<Message>? list;
  Chat? chat;
  bool isShop;
  @override
  Widget build(BuildContext context) {
    return GroupedListView<Message, DateTime>(
      order: GroupedListOrder.DESC,
      elements: list!,
      groupBy: (message) {
        return DateTime(
            message.time!.toDate().year,
            message.time!.toDate().month,
            message.time!.toDate().day,
            message.time!.toDate().hour);
      },
      physics: const BouncingScrollPhysics(),
      reverse: true,
      floatingHeader: true,
      shrinkWrap: true,
      useStickyGroupSeparators: true,
      itemComparator: (message1, message2) =>
          message1.time!.compareTo(message2.time!),
      groupHeaderBuilder: (message) => SizedBox(
        height: 35,
        child: Center(
          child: Card(
            color: Colors.blueGrey,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                    CommondMethods.showHeaderTime(message.time!.toDate()))),
          ),
        ),
      ),
      itemBuilder: (context, message) {
        return MessageItemWidget(
          message: message,
          chat: chat,
          isShop: isShop,
        );
      },
    );

    //  ListView.builder(
    //   itemBuilder: (context, index) {
    //     return MessageItemWidget(
    //       message: list![index],
    //       chat: chat,
    //     );
    //   },
    //   itemCount: list!.length,
    // );
  }
}
