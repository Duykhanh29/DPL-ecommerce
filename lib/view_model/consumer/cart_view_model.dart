import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/repositories/voucher_repo.dart';
import 'package:dpl_ecommerce/utils/common/common_methods.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:dpl_ecommerce/view_model/user_view_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  Cart? cart;
  void setCart(Cart c) {
    cart = c;
    // notifyListeners();
  }

  List<Voucher>? listVoucher;
  void setListVoucher(List<Voucher> list) {
    listVoucher = list;
    // notifyListeners();
  }

  List<ProductInCartModel> list = [];
  int totalCost = 0;
  int savingCost = 0;
  bool isCheckedALl = false;
  void reset() {
    list = [];
    totalCost = 0;
    savingCost = 0;
    isCheckedALl = false;
    notifyListeners();
  }

//  temt variables

  void calculateCostInCart() {
    int totalCost = 0;
    int savingCost = 0;
    for (var product in cart!.productInCarts) {
      totalCost += product.cost;
      int cost = product.cost;
      int savingPrice = 0;
      if (product.voucherID != null) {
        Voucher? voucher =
            CommondMethods.getVoucherFromID(listVoucher!, product.voucherID!);
        if (voucher != null &&
            voucher.expDate!.compareTo(Timestamp.fromDate(DateTime.now())) >
                0) {
          if (voucher.discountAmount != null) {
            cost -= voucher.discountAmount!;
            savingPrice += voucher.discountAmount!;
          } else {
            double percent = voucher.discountPercent! / 100;
            int savingPrice = (cost * percent).toInt();
            cost -= savingPrice;
          }
        }
      }
      cost = cost * product.quantity;
      totalCost += cost;
      savingCost += savingPrice;
    }
    cart!.savingCost = savingCost;
    cart!.totalCost = totalCost;
    notifyListeners();
  }

  void addToCart(ProductInCartModel product) {
    cart!.productInCarts.add(product);
    notifyListeners();
  }

  void deleteFromCart(ProductInCartModel product) {
    cart!.productInCarts.removeWhere((element) => element.id == product.id);
    calculateCostInCart();
    calculateCosts();
    if (list.isNotEmpty) {
      list.removeWhere((element) => product.id == element.id);
      calculateCosts();
    }
    notifyListeners();
  }

  void updateNumber(int newQuantity, String productInCartID) {
    if (newQuantity > 0) {
      for (var product in cart!.productInCarts) {
        if (productInCartID == product.id) {
          product.quantity = newQuantity;
        }
      }
      calculateCostInCart();
      calculateCosts();
      notifyListeners();
    }
  }

  void updateSize(String newSize, String productInCartID) {
    for (var product in cart!.productInCarts) {
      if (productInCartID == product.id) {
        product.size = newSize;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateType(String newType, String productInCartID) {
    for (var product in cart!.productInCarts) {
      if (productInCartID == product.id) {
        product.type = newType;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateColor(String newColor, String productInCartID) {
    for (var product in cart!.productInCarts) {
      if (productInCartID == product.id) {
        product.color = newColor;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateProductInCart(
      ProductInCartModel productInCartModel, String productInCartID) {
    for (var product in cart!.productInCarts) {
      if (productInCartID == product.id) {
        product = productInCartModel;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  //

  void checkProduct(ProductInCartModel productInCartModel) {
    list.add(productInCartModel);
    if (list.length == cart!.productInCarts.length) {
      isCheckedALl = true;
    }
    calculateCosts();
    notifyListeners();
  }

  void calculateCosts() {
    totalCost = 0;
    savingCost = 0;
    for (var element in list) {
      int cost = element.cost;
      int savingPrice = 0;
      if (element.voucherID != null) {
        Voucher? voucher =
            CommondMethods.getVoucherFromID(listVoucher!, element.voucherID!);
        if (voucher != null &&
            voucher.expDate!.compareTo(Timestamp.fromDate(DateTime.now())) >
                0) {
          if (voucher.discountAmount != null) {
            cost -= voucher.discountAmount!;
            savingPrice += voucher.discountAmount!;
          } else {
            double percent = voucher.discountPercent! / 100;
            int savingPrice = (cost * percent).toInt();
            cost -= savingPrice;
          }
        } else {
          print("Im oke");
        }
      }
      cost = cost * element.quantity;
      totalCost += cost;
      savingCost += savingPrice;
    }
  }

  void uncheckedProduct(ProductInCartModel productInCartModel) {
    list.removeWhere((element) => element.id == productInCartModel.id);
    calculateCosts();
    isCheckedALl = false;
    notifyListeners();
  }

  void toggleCheckAll() {
    isCheckedALl = !isCheckedALl;
    if (isCheckedALl) {
      list = List.from(cart!.productInCarts);
    } else {
      list = [];
    }
    notifyListeners();
    calculateCosts();
    notifyListeners();
  }
}

class SelectedProductInCart {
  bool isSelected;
  ProductInCartModel productInCartModel;
  SelectedProductInCart(
      {required this.productInCartModel, this.isSelected = false});
}
