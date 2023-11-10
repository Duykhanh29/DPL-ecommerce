import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final Cart cart = Cart(
    productInCarts: [
      ProductInCartModel(
          cost: 240000,
          quantity: 2,
          color: "Red",
          currencyID: "currencyID01",
          id: "productInCartModelID01",
          productID: "productID01",
          productImage:
              "https://static.addtoany.com/images/dracaena-cinnabari.jpg",
          productName: "Sadfsf",
          size: "L",
          type: "Wooden",
          userID: "userID01"),
      ProductInCartModel(
          cost: 240000,
          quantity: 2,
          color: "Red",
          currencyID: "currencyID01",
          id: "productInCartModelID01",
          productID: "productID01",
          productImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTq29z2MgTbf2LERHqbHkT1KGAv1WwxXyYSnw&usqp=CAU",
          productName: "Sadfsf",
          size: "L",
          type: "Wooden",
          userID: "userID01"),
      ProductInCartModel(
          cost: 180000,
          quantity: 1,
          color: "Blue",
          currencyID: "currencyID02",
          id: "productInCartModelID02",
          productID: "productID02",
          productImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3UTIruXjQnL8lIc25soS3jNKnW-zLMpoP6A&usqp=CAU",
          productName: "Rose",
          size: "M",
          type: "Flower",
          userID: "userID02"),
      ProductInCartModel(
          cost: 120000,
          quantity: 3,
          color: "Green",
          currencyID: "currencyID03",
          id: "productInCartModelID03",
          productID: "productID03",
          productImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2T2ayBMxgRLsBOS5MOQ5VFcLET7pndXGPIA&usqp=CAU",
          productName: "Cactus",
          size: "S",
          type: "Spiky",
          userID: "userID03"),
      ProductInCartModel(
          cost: 350000,
          quantity: 1,
          color: "Yellow",
          currencyID: "currencyID04",
          id: "productInCartModelID04",
          productID: "productID04",
          productImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrKHPsvNDJHY9tWpkHrfkfo8Dkf0LvZU3Hdg&usqp=CAUg",
          productName: "Sunflower",
          size: "XL",
          type: "Blooming",
          userID: "userID04"),
      ProductInCartModel(
          cost: 50000,
          quantity: 5,
          color: "Purple",
          currencyID: "currencyID05",
          id: "productInCartModelID05",
          productID: "productID05",
          productImage:
              "https://media.macphun.com/img/uploads/customer/how-to/570/15550740495cb08c019f4a94.42766927.jpg?q=85&w=1340",
          productName: "Lavender",
          size: "M",
          type: "Aromatic",
          userID: "userID05"),
      ProductInCartModel(
          cost: 280000,
          quantity: 2,
          color: "Orange",
          currencyID: "currencyID06",
          id: "productInCartModelID06",
          productID: "productID06",
          productImage:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_ums6Rp3LJDJZ4ClL81ZAa1x7Jos8YVCdKg&usqp=CAU",
          productName: "Orange",
          size: "L",
          type: "Juicy",
          userID: "userID06"),
      ProductInCartModel(
          cost: 75000,
          quantity: 1,
          color: "White",
          currencyID: "currencyID07",
          id: "productInCartModelID07",
          productID: "productID07",
          productImage:
              "https://i.insider.com/60638bd66183e1001981966a?width=1136&format=jpeg",
          productName: "Lily",
          size: "S",
          type: "Elegant",
          userID: "userID07"),
      ProductInCartModel(
          cost: 200000,
          quantity: 4,
          color: "Brown",
          currencyID: "currencyID08",
          id: "productInCartModelID08",
          productID: "productID08",
          productImage:
              "https://media.istockphoto.com/id/1352890602/photo/close-up-of-a-businessman-sitting-at-his-desk-and-using-a-navigation-app-on-his-cell-phone.jpg?s=612x612&w=0&k=20&c=yHWBg9Rv8UwKq78iRN34YRJRjI4XCDr-1saebzRf0pM=",
          productName: "Bonsai",
          size: "M",
          type: "Miniature",
          userID: "userID08"),
      ProductInCartModel(
          cost: 300000,
          quantity: 3,
          color: "Pink",
          currencyID: "currencyID09",
          id: "productInCartModelID09",
          productID: "productID09",
          productImage:
              "https://media.istockphoto.com/id/1058305310/photo/connected-to-all-that-she-needs.jpg?s=612x612&w=0&k=20&c=F0JYRwD0TImf5lqVZkMDqckH0Cx_l9WxxEBfVaHSppg=",
          productName: "Cherry Blossom",
          size: "L",
          type: "Delicate",
          userID: "userID09"),
      ProductInCartModel(
          cost: 180000,
          quantity: 2,
          color: "Gray",
          currencyID: "currencyID10",
          id: "productInCartModelID10",
          productID: "productID10",
          productImage:
              "https://www.freecodecamp.org/news/content/images/2022/04/derick-mckinney-oARTWhz1ACc-unsplash.jpg",
          productName: "Succulent",
          size: "S",
          type: "Drought-resistant",
          userID: "userID10"),
      ProductInCartModel(
          cost: 120000,
          quantity: 1,
          color: "Black",
          currencyID: "currencyID11",
          id: "productInCartModelID11",
          productID: "productID11",
          productImage:
              "https://images.pexels.com/photos/4603884/pexels-photo-4603884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
          productName: "Tulip",
          size: "XL",
          type: "Vibrant",
          userID: "userID11"),
    ],
    savingCost: 25000,
    totalCost: 250000,
    userID: "userID01",
  );
  List<ProductInCartModel> list = [];
  int totalCost = 0;
  int savingCost = 0;
  bool isCheckedALl = false;

  void calculateCostInCart() {
    int totalCost = 0;
    int savingCost = 0;
    for (var product in cart.productInCarts!) {
      totalCost += product.cost;
      // savingCost += 5000;
    }
    cart.savingCost = savingCost;
    cart.totalCost = totalCost;
    notifyListeners();
  }

  void addToCart(ProductInCartModel product) {
    cart.productInCarts!.add(product);
    notifyListeners();
  }

  void deleteFromCart(ProductInCartModel product) {
    cart.productInCarts!.removeWhere((element) => element.id == product.id);
    calculateCostInCart();
    calculateCosts();
    notifyListeners();
  }

  void updateNumber(int newQuantity, String productInCartID) {
    for (var product in cart.productInCarts!) {
      if (productInCartID == product.id) {
        product.quantity = newQuantity;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateSize(String newSize, String productInCartID) {
    for (var product in cart.productInCarts!) {
      if (productInCartID == product.id) {
        product.size = newSize;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateType(String newType, String productInCartID) {
    for (var product in cart.productInCarts!) {
      if (productInCartID == product.id) {
        product.type = newType;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateColor(String newColor, String productInCartID) {
    for (var product in cart.productInCarts!) {
      if (productInCartID == product.id) {
        product.color = newColor;
      }
    }
    calculateCostInCart();
    notifyListeners();
  }

  void updateProductInCart(
      ProductInCartModel productInCartModel, String productInCartID) {
    for (var product in cart.productInCarts!) {
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
    calculateCosts();
    notifyListeners();
  }

  void calculateCosts() {
    totalCost = 0;
    savingCost = 0;
    for (var element in list) {
      totalCost += element.cost;
      savingCost += 5000;
    }
  }

  void uncheckedProduct(ProductInCartModel productInCartModel) {
    list.removeWhere((element) => element.id == productInCartModel.id);
    calculateCosts();
    notifyListeners();
  }

  void toggleCheckAll() {
    isCheckedALl = !isCheckedALl;
    if (isCheckedALl) {
      list = cart.productInCarts!;
    } else {
      list = [];
    }

    calculateCosts();
    notifyListeners();
  }
}
