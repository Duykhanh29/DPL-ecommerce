import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';

class ShopViewModel extends ChangeNotifier {
  Shop? shop;
  void setShopInfo(Shop s) {
    shop = s;
    notifyListeners();
  }

  UserFirestoreDatabase userFirestoreDatabase = UserFirestoreDatabase();
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  UserModel? currentUser;
  ShopViewModel(this.currentUser) {
    if (currentUser != null) {
      fetchData(currentUser!.userInfor!.sellerInfor!.shopIDs![0]);
    }
    notifyListeners();
  }
  Future fetchData(String id) async {
    shop = await firestoreDatabase.getSHopByID(id);
    notifyListeners();
  }
}
