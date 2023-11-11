import 'package:dpl_ecommerce/models/product_in_cart_model.dart';

class CommondMethods {
  CommondMethods._();
  static List<ProductInCartModel> sortByTime(List<ProductInCartModel> list) {
    List<ProductInCartModel> result = list;
    result.sort(
      (a, b) => b.createdAt!.compareTo(a.createdAt!),
    );
    return result;
  }
}
