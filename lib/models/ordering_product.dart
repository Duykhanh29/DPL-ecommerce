import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum DeliverStatus { processing, confirmed, delivering, delivered, isCanceled }

class OrderingProduct {
  String? id;
  String? productID;
  String? userID;
  String? voucherID;
  int? price;
  int? realPrice;
  int? quantity;
  String? size;
  String? color;
  String? type;
  Timestamp? date;
  DeliverStatus? deliverStatus;
  OrderingProduct({
    this.deliverStatus,
    this.id,
    this.price,
    this.productID,
    this.realPrice,
    this.userID,
    this.voucherID,
    this.quantity,
    this.size,
    this.color,
    this.type,
    this.date,
  }) {
    id ??= Uuid().v4();
  }
  factory OrderingProduct.fromJson(Map<String, dynamic> json) {
    print("${json['quantity']}");
    return OrderingProduct(
        deliverStatus: DeliverStatus.values.firstWhere((element) =>
            element.toString().split(".").last == json['deliverStatus']),
        productID: json['productID'],
        id: json['id'],
        price: json['price'],
        realPrice: json['realPrice'],
        voucherID: json['voucherID'],
        userID: json['userID'],
        quantity: json['quantity'],
        size: json['size'],
        color: json['color'],
        type: json['type'],
        date: (json['date'] as Timestamp?));
  }
  Map<String, dynamic> toJson() => {
        'deliverStatus': deliverStatus.toString().split(".").last,
        'productID': productID,
        'id': id,
        'price': price,
        'realPrice': realPrice,
        'voucherID': voucherID,
        'userID': userID,
        'quantity': quantity,
        'size': size,
        'color': color,
        'type': type,
        'date': date,
      };
}
