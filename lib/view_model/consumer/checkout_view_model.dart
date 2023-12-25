import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/order_model.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:flutter/material.dart';

class CheckoutViewModel extends ChangeNotifier {
  AddressInfor? addressInfor;
  List<OrderingProduct>? listOrderingProduct;
  List<String>? listProductInCartID;
  Order? order;
  // for buy now
  int initialPurcharsingNumber = 1;
  String? type;
  String? size;
  String? color;
  List<String>? voucherIDs;

  void addNewVoucher(String voucherID) {
    voucherIDs!.add(voucherID);
    notifyListeners();
  }

  void setListProductInCartID(List<String> list) {
    listProductInCartID = list;
    notifyListeners();
  }

  void increaseNumber() {
    initialPurcharsingNumber++;
    notifyListeners();
  }

  void decreaseNumber() {
    if (initialPurcharsingNumber > 1) {
      initialPurcharsingNumber--;
      notifyListeners();
    }
  }

  void setOrder(Order o) {
    order = o;
    notifyListeners();
  }

  void resetOrder() {
    order = null;
    notifyListeners();
  }

  void setListOrderingProduct(List<OrderingProduct>? list) {
    listOrderingProduct = list;
    notifyListeners();
  }

  void resetOrderingProduct() {
    listOrderingProduct = null;
    notifyListeners();
  }

  void setAddressInfor(AddressInfor address) {
    addressInfor = address;
    notifyListeners();
  }

  void reset() {
    addressInfor = null;
    listOrderingProduct = null;
    order = null;
    voucherIDs = [];
    initialPurcharsingNumber = 1;
    color = null;
    type = null;
    size = null;
    notifyListeners();
  }

  void changeColor(String newColor) {
    color = newColor;
    notifyListeners();
  }

  void changeSize(String newSize) {
    size = newSize;
    notifyListeners();
  }

  void changeType(String newType) {
    type = newType;
    notifyListeners();
  }

  // void initialize({String? firstType, String? firstSize, String? firstColor}) {
  //   type = firstType;
  //   color = firstColor;
  //   size = firstSize;
  // }
}
