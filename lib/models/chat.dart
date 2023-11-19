import 'package:dpl_ecommerce/models/message.dart';
import 'package:uuid/uuid.dart';

class Chat {
  String? id;
  String? userID;
  String? sellerID;
  String? shopID;
  String? shopName;
  String? userName;
  String? shopLogo;
  String? userAvatar;
  List<Message>? listMsg;
  String? lastMessage;
  ChatType? lastChatType;
  Chat(
      {this.id,
      this.sellerID,
      this.listMsg,
      this.shopID,
      this.userID,
      this.shopLogo,
      this.shopName,
      this.userAvatar,
      this.userName,
      this.lastChatType,
      this.lastMessage}) {
    id ??= Uuid().v4();
  }
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        shopLogo: json['shopLogo'],
        shopName: json['shopName'],
        userAvatar: json['userAvatar'],
        userName: json['userName'],
        id: json['id'],
        userID: json['userID'],
        shopID: json['shopID'],
        // ignore: unnecessary_null_comparison, prefer_null_aware_operators
        listMsg: (json['listMsg'] as List<dynamic>) == null
            ? null
            : (json['listMsg'] as List<dynamic>)
                .map((e) => Message.fromJson(e))
                .toList(),
        sellerID: json['sellerID'],
        lastChatType: json['lastChatType'],
        lastMessage: json['lastMessage']);
  }
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'id': id,
        'shopID': shopID,
        'listMsg': listMsg!.map((e) => e.toJson()).toList(),
        'shopLogo': shopLogo,
        'shopName': shopName,
        'userAvatar': userAvatar,
        'userName': userName,
        'sellerID': sellerID,
        'lastMessage': lastMessage,
        'lastChatType': lastChatType
      };
}
