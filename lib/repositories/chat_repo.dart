import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/message.dart';

class ChatRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  Stream<List<Chat>?> getAllChatByUser(String uid) {
    return firestoreDatabase.getAllChatByUser(uid);
  }

  Stream<List<Message>?> getListMsgInAChatByID(String id) {
    return firestoreDatabase.getListMsgInAChatByID(id);
  }

  Stream<List<Chat>?> getAllChatBySellerID(String uid) {
    return firestoreDatabase.getAllChatBySellerID(uid);
  }

  Future<void> addNewChat(Chat chat) async {
    await firestoreDatabase.addChat(chat);
  }

  Future<void> sendAMessage(
      {required String chatID, required Message msg}) async {
    await firestoreDatabase.sendAMessage(chatID: chatID, msg: msg);
  }

  Future<Chat?> getChatByID(String id) async {
    return await firestoreDatabase.getChatByID(id);
  }

  Future<Chat?> getChatWithShop(
      {required String userID, required String shopID}) async {
    return await firestoreDatabase.getChatWithShop(
        userID: userID, shopID: shopID);
  }

  Future<Chat?> getChatWithUsers(
      {required String userID, required String sellerID}) async {
    return await firestoreDatabase.getChatWithUsers(
        userID: userID, sellerID: sellerID);
  }

  Future<bool?> checkExistedChatBox(String id) async {
    return await firestoreDatabase.checkExistedChatBox(id);
  }

  Future<bool?> checkExistedChatBoxWithShop(
      {required String userID, required String shopID}) async {
    return await firestoreDatabase.checkExistedChatBoxWithShop(
        userID: userID, shopID: shopID);
  }

  Future<bool?> checkExistedChatBoxWithUsers(
      {required String userID, required String sellerID}) async {
    return await firestoreDatabase.checkExistedChatBoxWithUsers(
        userID: userID, sellerID: sellerID);
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }

  final List<Chat> list = [
    Chat(
      id: "chatID01",
      shopID: "shopID01",
      userID: "userID100",
      shopLogo:
          "https://i.pinimg.com/1200x/0d/cf/b5/0dcfb548989afdf22afff75e2a46a508.jpg",
      shopName: "DDK29",
      userAvatar:
          "https://imgv3.fotor.com/images/blog-cover-image/part-blurry-image.jpg",
      userName: "Khanh",
      listMsg: [
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
            productID: "ProductID01",
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
            productID: "ProductID01",
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
                "https://inkythuatso.com/uploads/thumbnails/800/2021/10/logo-vinfast-inkythuatso-21-11-22-46.jpg",
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
            productID: "ProductID01",
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
            productID: "ProductID01",
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
                "https://inkythuatso.com/uploads/thumbnails/800/2021/10/logo-vinfast-inkythuatso-21-11-22-46.jpg",
            id: "messageID08",
            productID: null,
            senderID: "userID100",
            isShop: false,
            time: Timestamp.fromDate(DateTime.now()),
            receiverID: "userID02"),
      ],
    ),
    Chat(
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
              "https://inkythuatso.com/uploads/thumbnails/800/2021/10/logo-vinfast-inkythuatso-21-11-22-46.jpg",
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
}
