import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier {
  // varriables for adding to cart
  int choseNumber = 1;
  String? color;
  String? type;
  String? size;
  List<String>? voucherIDs;
  void addNewVoucher(String voucherID) {
    voucherIDs!.add(voucherID);
    notifyListeners();
  }

  void reset() {
    choseNumber = 1;
    color = null;
    type = null;
    size = null;
    notifyListeners();
  }

  void decreaseNumber() {
    if (choseNumber > 1) {
      choseNumber--;
    }
    notifyListeners();
  }

  void increaseNumner() {
    choseNumber++;
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
