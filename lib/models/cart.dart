import 'package:dpl_ecommerce/models/product_in_cart_model.dart';

class Cart {
  String? userID;
  List<ProductInCartModel>? productInCarts;
  int totalCost;
  int savingCost;
  Cart(
      {this.productInCarts,
      this.savingCost = 0,
      this.totalCost = 0,
      this.userID});
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
        productInCarts: (json['productInCarts']) != null
            ? (json['productInCarts'] as List<dynamic>)
                .map((e) => ProductInCartModel.fromJson(e))
                .toList()
            : null,
        savingCost: json['savingCost'],
        totalCost: json['totalCost'],
        userID: json['userID']);
  }
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'totalCost': totalCost,
        'savingCost': savingCost,
        'productInCarts': productInCarts != null
            ? productInCarts!.map((e) => e.toJson()).toList()
            : null
      };
}
