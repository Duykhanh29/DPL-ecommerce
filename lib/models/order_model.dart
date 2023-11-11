import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:uuid/uuid.dart';

enum DeliverStatus { processing, confirmed, delivering, delivered, isCanceled }

class Order {
  String? id;
  String? userID;
  String? paymentTypeID;
  String? deliverServiceID;
  DeliverStatus? deliverStatus;
  int? shippingCost;
  int? totalCost;
  String? voucherDiscountID;
  bool isCancelled;
  AddressInfor? receivedAddress;
  List<OrderingProduct>? orderingProductsID;
  Order(
      {this.deliverServiceID,
      this.deliverStatus,
      this.id,
      this.isCancelled = false,
      this.orderingProductsID,
      this.paymentTypeID,
      this.receivedAddress,
      this.shippingCost,
      this.totalCost,
      this.userID,
      this.voucherDiscountID}) {
    id ??= Uuid().v4();
  }
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      deliverServiceID: json['deliverServiceID'],
      deliverStatus: DeliverStatus.values.firstWhere((element) =>
          element.toString().split(".").last == json['deliverStatus']),
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
    );
  }
  Map<String, dynamic> toJson() => {
        'deliverServiceID': deliverServiceID,
        'deliverStatus': deliverStatus.toString().split(".").last,
        'isCancelled': isCancelled,
        'id': id,
        'orderingProductsID':
            orderingProductsID!.map((e) => e.toJson()).toList(),
        'paymentTypeID': paymentTypeID,
        'userID': userID,
        'voucherDiscountID': voucherDiscountID,
        'shippingCost': shippingCost,
        'receivedAddress': receivedAddress!.toJson(),
        'totalCost': totalCost
      };
}
