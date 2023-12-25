import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:uuid/uuid.dart';

class Order {
  String? id;
  String? userID;
  String? paymentTypeID;
  String? deliverServiceID;
  int? shippingCost;
  int? totalCost;
  int? totalProduct;
  String? voucherDiscountID;
  bool isCancelled;
  AddressInfor? receivedAddress;
  Timestamp? time;
  List<OrderingProduct>? orderingProductsID;
  Order(
      {this.deliverServiceID,
      this.id,
      this.isCancelled = false,
      this.orderingProductsID,
      this.paymentTypeID,
      this.receivedAddress,
      this.shippingCost,
      this.totalCost,
      this.userID,
      this.voucherDiscountID,
      this.totalProduct,
      this.time}) {
    id ??= Uuid().v4();
  }
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        deliverServiceID: json['deliverServiceID'],
        isCancelled: json['isCancelled'],
        id: json['id'],
        orderingProductsID: (json['orderingProductsID'] as List<dynamic>)
            .map((e) => OrderingProduct.fromJson(e))
            .toList(),
        paymentTypeID: json['paymentTypeID'],
        userID: json['userID'],
        voucherDiscountID: json['voucherDiscountID'],
        shippingCost: json['shippingCost'],
        receivedAddress: AddressInfor.fromJson(json['receivedAddress']),
        totalCost: json['totalCost'],
        totalProduct: json['totalProduct'],
        time: (json['time'] as Timestamp?));
  }
  Map<String, dynamic> toJson() => {
        'deliverServiceID': deliverServiceID,
        'isCancelled': isCancelled,
        'id': id,
        'orderingProductsID':
            orderingProductsID!.map((e) => e.toJson()).toList(),
        'paymentTypeID': paymentTypeID,
        'userID': userID,
        'voucherDiscountID': voucherDiscountID,
        'shippingCost': shippingCost,
        'receivedAddress': receivedAddress!.toJson(),
        'totalCost': totalCost,
        'totalProduct': totalProduct,
        'time': time
      };
}
