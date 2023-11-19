import 'package:uuid/uuid.dart';

enum ChatType { image, link, video, text }

class Message {
  String? id;
  bool? isShop;
  String? senderID;
  String? receiverID;
  DateTime? time;
  String? content;
  ChatType? chatType;
  String? productID;
  Message(
      {this.chatType,
      this.content,
      this.id,
      this.productID,
      this.senderID,
      this.isShop,
      this.receiverID,
      this.time}) {
    id ??= Uuid().v4();
  }
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      chatType: ChatType.values.firstWhere(
          (element) => element.toString().split(".").last == json['chatType']),
      id: json['id'],
      senderID: (json['senderID']),
      productID: json['productID'],
      time: json['time'],
      isShop: json['isShop'],
      receiverID: json['receiverID'],
    );
  }
  Map<String, dynamic> toJson() => {
        'content': content,
        'chatType': chatType.toString().split(".").last,
        'receiverID': receiverID,
        'id': id,
        'productID': productID,
        'senderID': senderID,
        'time': time,
        'isShop': isShop,
      };
}
