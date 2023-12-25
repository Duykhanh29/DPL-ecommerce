import 'dart:math';

import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:flutter/material.dart';

class AddressViewModel extends ChangeNotifier {
  List<AddressInfor>? listAddress;
  AddressInfor? defaultAddress;
  AddressInfor? orderingAddress;
  void setListAddressInfor(List<AddressInfor>? list) {
    listAddress = list;
    notifyListeners();
  }

  void setDefaultAddress(AddressInfor add) {
    defaultAddress = add;
    notifyListeners();
  }

  // for order(checkout)
  void setOrderingAddress(AddressInfor add) {
    orderingAddress = add;
    notifyListeners();
  }

  void resetOrderingAddress() {
    orderingAddress = null;
    notifyListeners();
  }

  void delete(String id) {
    listAddress!.removeWhere((element) => element.id! == id);
    notifyListeners();
  }

  void addAdd(AddressInfor address) {
    listAddress!.add(address);
    notifyListeners();
  }

  void updateAddress(AddressInfor addressInfor) {
    for (var element in listAddress!) {
      if (element.id == addressInfor.id) {
        element = addressInfor;
      }
    }
    notifyListeners();
  }
}
