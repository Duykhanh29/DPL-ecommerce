import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/favourite_product.dart';

class WishListRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();

  Future<List<FavouriteProduct>?> getListFavouriteProduct(String uid) async {
    return firestoreDatabase.getListFavouriteProduct(uid);
  }

  Stream<List<FavouriteProduct>?> getAllFavouriteProduct(String uid) {
    return firestoreDatabase.getAllFavouriteProduct(uid);
  }

  Stream<bool?> isFavouriteProduct(
      {required String uid, required String productID}) {
    return firestoreDatabase.isFavouriteProduct(uid, productID);
  }

  Future<bool?> isFavourite(
      {required String uid, required String productID}) async {
    return await firestoreDatabase.isFavourite(uid, productID);
  }

  Future<void> addToFavourite(FavouriteProduct favouriteProduct) async {
    await firestoreDatabase.addToFavourite(favouriteProduct);
  }

  Future<void> deleteFavourite(String id) async {
    await firestoreDatabase.deleteFavourite(id);
  }

  Future<void> deleteFavouriteByParams(
      {required String uid, required String productID}) async {
    await firestoreDatabase.deleteFavouriteByParams(
        uid: uid, productID: productID);
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
