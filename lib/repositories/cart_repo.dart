import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';

class CartRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  Future<Cart?> getCart(String uid) async {
    Cart? cart = await firestoreDatabase.getCartByUserID(uid);
    return cart;
  }

  Future<void> addToCart(
      {required String uid,
      ProductInCartModel? productInCartModel,
      int savingCost = 0}) async {
    await firestoreDatabase.addToCart(
        uid: uid,
        productInCartModel: productInCartModel,
        savingCost: savingCost);
  }

  Future<void> deleteProductInCartModel(
      {required String uid,
      ProductInCartModel? productInCartModel,
      int savingCost = 0}) async {
    await firestoreDatabase.deleteProductInCartModel(
        uid: uid,
        productInCartModel: productInCartModel,
        savingCost: savingCost);
  }

  Future<void> deleteByProductInCartModelID(
      {required String uid,
      String? productInCartModelID,
      int savingCost = 0}) async {
    await firestoreDatabase.deleteByProductInCartModelID(
        uid: uid,
        productInCartModelID: productInCartModelID,
        savingCost: savingCost);
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
