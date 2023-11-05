import 'package:uuid/uuid.dart';

class OrderingProduct {
  String? id;
  String? productID;
  String? userID;
  String? voucherID;
  int? price;
  int? realPrice;
  OrderingProduct(
      {this.id,
      this.price,
      this.productID,
      this.realPrice,
      this.userID,
      this.voucherID}) {
    id ??= Uuid().v4();
  }
  factory OrderingProduct.fromJson(Map<String, dynamic> json) {
    return OrderingProduct(
      productID: json['productID'],
      id: json['id'],
      price: json['price'],
      realPrice: json['realPrice'],
      voucherID: json['voucherID'],
      userID: json['userID'],
    );
  }
  Map<String, dynamic> toJson() => {
        'productID': productID,
        'id': id,
        'price': price,
        'realPrice': realPrice,
        'voucherID': voucherID,
        'userID': userID,
      };
}
