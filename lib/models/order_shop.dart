import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:uuid/uuid.dart';

enum PaymentStatus { unpaid, paid }

class OrderShop {
  String? id;
  String? orderCode;
  String? orderingProductID;
  Timestamp? orderDate;
  DeliverStatus? deliverStatus;
  PaymentStatus? paymentStatus;
  int? totalPrice;
  String? deliverServiceID;
  String? shopID;
  int quatity;
  int? singlePrice;
  String? size;
  String? color;
  String? type;
  String? productID;
  OrderShop(
      {this.deliverStatus,
      this.id,
      this.orderCode,
      this.orderDate,
      this.paymentStatus,
      this.totalPrice,
      this.deliverServiceID,
      this.shopID,
      this.color,
      this.productID,
      this.quatity = 1,
      this.singlePrice,
      this.size,
      this.orderingProductID,
      this.type}) {
    id ??= const Uuid().v4();
  }

  factory OrderShop.fromJson(Map<String, dynamic> json) {
    return OrderShop(
      orderingProductID: json['orderingProductID'],
      id: json['id'],
      orderCode: json['orderCode'],
      orderDate: json['orderDate'],
      deliverStatus: DeliverStatus.values.firstWhere((element) =>
          element.toString().split(".").last == json['deliverStatus']),
      totalPrice: json['totalPrice'],
      paymentStatus: PaymentStatus.values.firstWhere(
        (element) =>
            element.toString().split(".").last == json['paymentStatus'],
      ),
      deliverServiceID: json['deliverServiceID'],
      shopID: json['shopID'],
      color: json['color'],
      productID: json['productID'],
      quatity: json['quatity'],
      singlePrice: json['singlePrice'],
      size: json['size'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() => {
        'orderCode': orderCode,
        'orderDate': orderDate,
        'deliverStatus': deliverStatus.toString().split(".").last,
        'id': id,
        'totalPrice': totalPrice,
        'paymentStatus': paymentStatus.toString().split(".").last,
        'deliverService': deliverServiceID,
        'shopID': shopID,
        'productID': productID,
        'color': color,
        'quatity': quatity,
        'singlePrice': singlePrice,
        'type': type,
        'orderingProductID': orderingProductID
      };
}
