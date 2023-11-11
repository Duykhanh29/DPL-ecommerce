import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier {
  // varriables for adding to cart
  int choseNumber = 1;
  String? color;
  String? type;
  String? size;
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
}
