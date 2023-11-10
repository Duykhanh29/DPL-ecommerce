import 'package:uuid/uuid.dart';

class ProductInCartModel {
  String? id;
  // String? shopID;
  String? userID;
  String? productID;
  String? productName;
  String? productImage;
  int quantity;
  int cost;
  String? currencyID;
  String? size;
  String? type;
  String? color;
  String? voucherID;
  ProductInCartModel(
      {this.color,
      required this.cost,
      this.currencyID,
      this.id,
      this.productID,
      this.productImage,
      this.productName,
      required this.quantity,
      this.size,
      this.type,
      this.userID,
      this.voucherID}) {
    id ??= Uuid().v4();
  }
  factory ProductInCartModel.fromJson(Map<String, dynamic> json) {
    return ProductInCartModel(
      cost: json['cost'],
      quantity: json['quantity'],
      color: json['color'],
      currencyID: json['currencyID'],
      id: json['id'],
      productID: json['productID'],
      productImage: json['productImage'],
      productName: json['productName'],
      size: json['size'],
      type: json['type'],
      userID: json['userID'],
      voucherID: json['voucherID'],
    );
  }
  Map<String, dynamic> toJson() => {
        'cost': cost,
        'quantity': quantity,
        'color': color,
        'currencyID': currencyID,
        'id': id,
        'productID': productID,
        'productImage': productImage,
        'productName': productName,
        'type': type,
        'size': size,
        'userID': userID,
        'voucherID': voucherID,
      };
}
