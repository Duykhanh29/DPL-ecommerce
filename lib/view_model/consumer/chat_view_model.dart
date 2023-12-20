import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final List<Chat> list = [
    Chat(
      sellerID: "userID02",
      id: "chatID01",
      shopID: "shopID01",
      userID: "userID100",
      shopLogo:
          "https://i.pinimg.com/1200x/0d/cf/b5/0dcfb548989afdf22afff75e2a46a508.jpg",
      shopName: "DDK29",
      userAvatar:
          "https://imgv3.fotor.com/images/blog-cover-image/part-blurry-image.jpg",
      userName: "Khanh",
      lastChatType: ChatType.image,
      lastMessage:
          "https://archive.org/download/06-07-2016_Images_Images_page_1/02_PT_hero_42_153645159.jpg",
      listMsg: [
        Message(
          chatType: ChatType.text,
          content: "Hi, how can I help you",
          id: "messageID01",
          productID: null,
          senderID: "userID100",
          isShop: false,
          receiverID: "userID02",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
            chatType: ChatType.text,
            content: "Hello! How can I assist you today?",
            id: "messageID02",
            productID: "productID01",
            senderID: "userID02",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true,
            receiverID: "userID100"),
        Message(
            chatType: ChatType.text,
            content: "Hey there! Need any help?",
            id: "messageID03",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID02"),
        Message(
          chatType: ChatType.text,
          content: "Greetings! What can I do for you?",
          id: "messageID04",
          productID: null,
          senderID: "userID100",
          isShop: false,
          receiverID: "userID02",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
            chatType: ChatType.link,
            content: "https://www.youtube.com/",
            id: "messageID05",
            productID: "productID01",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true,
            senderID: "userID02",
            receiverID: "userID100"),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID06",
            productID: null,
            senderID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: false,
            receiverID: "userID02"),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID07",
            productID: null,
            senderID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: false,
            receiverID: "userID02"),
        Message(
            chatType: ChatType.image,
            content:
                "https://archive.org/download/06-07-2016_Images_Images_page_1/02_PT_hero_42_153645159.jpg",
            id: "messageID08",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID02"),
        Message(
          chatType: ChatType.text,
          content: "Hi, how can I help you",
          id: "messageID01",
          productID: null,
          senderID: "userID01",
          isShop: false,
          receiverID: "userID04",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
            chatType: ChatType.text,
            content: "Hello! How can I assist you today?",
            id: "messageID02",
            productID: "productID01",
            senderID: "userID02",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true,
            receiverID: "userID100"),
        Message(
            chatType: ChatType.text,
            content: "Hey there! Need any help?",
            id: "messageID03",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID02"),
        Message(
          chatType: ChatType.text,
          content: "Greetings! What can I do for you?",
          id: "messageID04",
          productID: null,
          senderID: "userID100",
          isShop: false,
          receiverID: "userID02",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
            chatType: ChatType.link,
            content: "https://www.youtube.com/",
            id: "messageID05",
            productID: "productID01",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true,
            senderID: "userID02",
            receiverID: "userID100"),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID06",
            productID: null,
            senderID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: false,
            receiverID: "userID02"),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID07",
            productID: null,
            senderID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: false,
            receiverID: "userID02"),
        Message(
            chatType: ChatType.image,
            content:
                "https://archive.org/download/06-07-2016_Images_Images_page_1/02_PT_hero_42_153645159.jpg",
            id: "messageID08",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID02"),
      ],
    ),
    Chat(
      lastChatType: ChatType.video,
      lastMessage:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      sellerID: "userID03",
      id: "chatID02",
      shopID: "shopID04",
      userID: "userID100",
      shopLogo:
          "https://cdn.shopify.com/shopifycloud/hatchful_web_two/bundles/4a14e7b2de7f6eaf5a6c98cb8c00b8de.png",
      userAvatar:
          "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs2/293064437/original/957c44f1e7889dd693c0fd5d789f2dbcc8509efd/edit-your-images-and-make-them-beautiful.jpg",
      shopName: "DDK0209",
      userName: "Duy Khanh",
      listMsg: [
        Message(
          chatType: ChatType.text,
          content: "Hi, how can I help you",
          id: "messageID01",
          productID: null,
          senderID: "userID100",
          isShop: false,
          receiverID: "userID03",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
          chatType: ChatType.text,
          content: "Hello! How can I assist you today?",
          id: "messageID02",
          productID: null,
          senderID: "userID03",
          isShop: true,
          receiverID: "userID100",
          time: Timestamp.fromDate(DateTime.now()),
        ),
        Message(
            chatType: ChatType.text,
            content: "Hey there! Need any help?",
            id: "messageID03",
            productID: null,
            senderID: "userID03",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true,
            receiverID: "userID100"),
        Message(
            chatType: ChatType.text,
            content: "Greetings! What can I do for you?",
            id: "messageID04",
            productID: null,
            senderID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: false,
            receiverID: "userID03"),
        Message(
            chatType: ChatType.link,
            content: "https://www.youtube.com/",
            id: "messageID05",
            productID: null,
            senderID: "userID03",
            receiverID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID06",
            productID: null,
            senderID: "userID03",
            receiverID: "userID100",
            time: Timestamp.fromDate(DateTime.now()),
            isShop: true),
        Message(
            chatType: ChatType.video,
            content:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
            id: "messageID07",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID03"),
        Message(
          chatType: ChatType.image,
          content:
              "https://archive.org/download/06-07-2016_Images_Images_page_1/02_PT_hero_42_153645159.jpg",
          id: "messageID08",
          productID: null,
          senderID: "userID100",
          isShop: false,
          receiverID: "userID03",
          time: Timestamp.fromDate(DateTime.now()),
        ),
      ],
    )
  ];
  void addNewChat(Chat chat) {
    list.add(chat);
    notifyListeners();
  }

  void sendMsgToAChatBox(Message message, String chatID) {
    for (var element in list) {
      if (element.id == chatID) {
        element.listMsg!.add(message);
        element.lastChatType = message.chatType;
        element.lastMessage = message.content;
      }
    }
    notifyListeners();
  }

  bool isNew = false;
  void changeIsNew() {
    isNew = true;
    notifyListeners();
  }

  void resetChangeNew() {
    isNew = false;
    notifyListeners();
  }
}
