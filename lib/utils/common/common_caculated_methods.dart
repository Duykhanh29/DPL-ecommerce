import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/voucher.dart';

class CommonCaculatedMethods {
  CommonCaculatedMethods._();
  // 1. caculate total cost in Cart
  static int caculateTotalCostInCart(List<ProductInCartModel> list) {
    int totalCost = 0;
    for (var product in list) {
      totalCost += product.cost;
      // savingCost += 5000;
    }
    return totalCost;
  }

  static int caculateSavignCost(Voucher voucher, int price) {
    int savingCost = 0;
    if (voucher.discountAmount != null) {
      savingCost = voucher.discountAmount!;
    } else {
      savingCost =
          (price) - ((price) * (voucher.discountPercent! / 100)).toInt();
    }
    return savingCost;
  }
}
