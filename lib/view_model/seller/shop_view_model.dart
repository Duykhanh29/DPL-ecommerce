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

  Future<void> onRefresh() async {
    reset();
    await fetchData(currentUser!.userInfor!.sellerInfor!.shopIDs![0]);
  }

  void reset() {
    shop = null;
    notifyListeners();
  }

  void updateTotalProduct(TypeOfTotalProduct type) {
    if (shop != null) {
      if (type == TypeOfTotalProduct.increase) {
        shop!.totalProduct++;
      } else {
        shop!.totalProduct--;
      }
      notifyListeners();
    }
  }

  void updateTotalOrder() {
    if (shop != null) {
      shop!.totalOrder++;
      notifyListeners();
    }
  }

  void updateTotalRevenue(int newRevenue) {
    if (shop != null) {
      shop!.totalRevenue = shop!.totalRevenue + newRevenue;
      notifyListeners();
    }
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
