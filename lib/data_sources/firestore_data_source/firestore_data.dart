import 'dart:async';

import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/currency_infor.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/utils/common/common_caculated_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  FirestoreDatabase();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //products section
  // products
  Future<void> postProduct(Product product) async {
    await _firestore
        .collection('products')
        .doc(product.id)
        .set(product.toJson());
  }

  Future<List<Product>?> getActiveProducts() async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        Product product = Product.fromJson(productData);
        list.add(product);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<Product>?> getListActiveProduct() async* {
    try {
      final ref = _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .snapshots();
      StreamController<List<Product>?> streamController =
          StreamController<List<Product>?>();
      StreamSubscription streamSubscription = ref.listen((event) {
        List<Product>? list = [];
        if (event.docs.isNotEmpty) {
          for (var data in event.docs) {
            // final dataHere = data.data();
            //  Product p = Product.fromJson({'id': data.id, ...data.data()});
            Product product = Product(
              id: data.id,
              availableQuantity: data.data()['availableQuantity'],
              categoryID: data.data()['categoryID'],
              description: data.data()['description'],
              colors: data.data()['colors'] != null
                  ? (data.data()['colors'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              createdAt: data.data()['createdAt'],
              images: data.data()['images'] != null
                  ? (data.data()['images'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              name: data.data()['name'],
              price: data.data()['price'],
              purchasingCount: data.data()['purchasingCount'],
              rating: data.data()['rating'],
              ratingCount: data.data()['ratingCount'],
              reviewIDs: data.data()['reviewIDs'] != null
                  ? (data.data()['reviewIDs'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              shopID: data.data()['shopID'],
              shopLogo: data.data()['shopLogo'],
              shopName: data.data()['shopName'],
              sizes: data.data()['sizes'] != null
                  ? (data.data()['sizes'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              types: data.data()['types'] != null
                  ? (data.data()['types'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              updatedAt: data.data()['updatedAt'],
              videos: data.data()['videos'] != null
                  ? (data.data()['videos'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null,
              voucherID: data.data()['voucherID'],
            );
            list.add(product);
          }
          streamController.sink.add(list);
        }
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Product?> getProductByID(String id) async {
    try {
      final productSnapshot =
          await _firestore.collection('products').doc(id).get();
      if (productSnapshot.exists) {
        Product product = Product.fromJson(
            {'id': productSnapshot.id, ...productSnapshot.data()!});
        return product;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateProduct({
    required String productID,
    int? quantity,
    int? cost,
    List<String>? colors,
    List<String>? types,
    List<String>? sizes,
    List<String>? images,
    List<String>? videos,
    String? description,
    int? ratingCount,
    int? purchasingCount,
  }) async {
// update product
  }
  Future<void> buyAProduct() async {}

  // get products list of a shop
  Future<List<Product>?> getProductListByShop(String shopID) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('shopID', isEqualTo: shopID)
          .get();
      for (var data in snapshot.docs) {
        Product product = Product(
          id: data.id,
          availableQuantity: data.data()['availableQuantity'],
          categoryID: data.data()['categoryID'],
          description: data.data()['description'],
          colors: data.data()['colors'] != null
              ? (data.data()['colors'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          createdAt: data.data()['createdAt'],
          images: data.data()['images'] != null
              ? (data.data()['images'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          name: data.data()['name'],
          price: data.data()['price'],
          purchasingCount: data.data()['purchasingCount'],
          rating: data.data()['rating'],
          ratingCount: data.data()['ratingCount'],
          reviewIDs: data.data()['reviewIDs'] != null
              ? (data.data()['reviewIDs'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          shopID: data.data()['shopID'],
          shopLogo: data.data()['shopLogo'],
          shopName: data.data()['shopName'],
          sizes: data.data()['sizes'] != null
              ? (data.data()['sizes'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          types: data.data()['types'] != null
              ? (data.data()['types'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          updatedAt: data.data()['updatedAt'],
          videos: data.data()['videos'] != null
              ? (data.data()['videos'] as List<dynamic>)
                  .map((e) => e.toString())
                  .toList()
              : null,
          voucherID: data.data()['voucherID'],
        );
        list.add(product);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getRelatedProduct(String categoryID) async {
    try {
      List<Product>? list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('categoryID', arrayContains: categoryID)
          // .limit(7)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          Product product = Product(
            id: data.id,
            availableQuantity: data.data()['availableQuantity'],
            categoryID: data.data()['categoryID'],
            description: data.data()['description'],
            colors: data.data()['colors'] != null
                ? (data.data()['colors'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            createdAt: data.data()['createdAt'],
            images: data.data()['images'] != null
                ? (data.data()['images'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            name: data.data()['name'],
            price: data.data()['price'],
            purchasingCount: data.data()['purchasingCount'],
            rating: data.data()['rating'],
            ratingCount: data.data()['ratingCount'],
            reviewIDs: data.data()['reviewIDs'] != null
                ? (data.data()['reviewIDs'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            shopID: data.data()['shopID'],
            shopLogo: data.data()['shopLogo'],
            shopName: data.data()['shopName'],
            sizes: data.data()['sizes'] != null
                ? (data.data()['sizes'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            types: data.data()['types'] != null
                ? (data.data()['types'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            updatedAt: data.data()['updatedAt'],
            videos: data.data()['videos'] != null
                ? (data.data()['videos'] as List<dynamic>)
                    .map((e) => e.toString())
                    .toList()
                : null,
            voucherID: data.data()['voucherID'],
          );
          list.add(product);
        }
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // shop sections
  // shop sections
  Future<void> addShop(Shop shop) async {
    await _firestore.collection('shops').doc(shop.id).set(shop.toJson());
  }

  Future<void> updateShop(
      {required String shopID,
      String? name,
      String? logo,
      int? rating,
      int? shopView,
      String? contactPhone,
      AddressInfor? addressInfor,
      String? shopDescription}) async {
    try {
      final shopDoc = _firestore.collection('shops');
      final snapshot = await shopDoc.doc(shopID).get();
      if (snapshot.exists) {
        final shopData = snapshot.data() as Map<String, dynamic>;
        // final
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Shop>?> getListShop() async {
    try {
      List<Shop> list = [];
      QuerySnapshot<Map<String, dynamic>> ref =
          await _firestore.collection('shops').get();
      for (var data in ref.docs) {
        Shop shop = Shop(
            id: data.id,
            logo: data.data()['logo'],
            name: data.data()['name'],
            addressInfor: AddressInfor.fromJson(data.data()['addressInfor']),
            contactPhone: data.data()['contactPhone'],
            rating: (data.data()['rating'] as double),
            ratingCount: data.data()['ratingCount'],
            shopDescription: data.data()['shopDescription'],
            shopView: data.data()['shopView'],
            totalProduct: data.data()['totalProduct']);
        list.add(shop);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // cart sections
  Future<void> addCart(Cart cart) async {
    await _firestore.collection('carts').doc(cart.userID).set(cart.toJson());
  }

  Future<void> addToCart(
      {required String uid,
      ProductInCartModel? productInCartModel,
      int savingCost = 0}) async {
    try {
      final querySnapshot = _firestore.collection('carts').get();
      final cartDocs = _firestore.collection('carts').doc(uid);
      // _firestore.runTransaction((transaction) async {
      //   DocumentSnapshot documentSnapshot = await transaction.get(cartDocs);
      final cartSnapshot = await cartDocs.get();
      final dataSnapshot = cartSnapshot.data();
      List<ProductInCartModel> listProductIncart = [];
      if (dataSnapshot!['productInCarts'] != null) {
        listProductIncart = (dataSnapshot['productInCarts'] as List<dynamic>)
            .map((e) => ProductInCartModel.fromJson(e))
            .toList();
        bool isExist = false;
        for (var productIncart in listProductIncart) {
          if (productInCartModel!.productID == productIncart.productID) {
            if (productIncart.color == productInCartModel.color) {
              if (productInCartModel!.type == productIncart.type) {
                if (productIncart.size == productInCartModel.size) {
                  if (productInCartModel!.cost == productIncart.cost) {
                    if (productIncart.voucherID ==
                        productInCartModel.voucherID) {
                      productIncart.quantity =
                          productInCartModel.quantity + productIncart.quantity;
                      isExist = true;
                    } else {
                      print("An error occured: voucher");
                    }
                  } else {
                    print("An error occured: cost");
                  }
                } else {
                  print("An error occured: size");
                }
              } else {
                print("An error occured: type");
              }
            } else {
              print("An error occured: color");
            }
          } else {
            print("An error occured: id");
          }
          // &&
          //     productIncart.color == productInCartModel.color &&
          //     productInCartModel!.type == productIncart.type &&
          //     productIncart.size == productInCartModel.size &&
          //     productInCartModel!.cost == productIncart.cost &&
          //     productIncart.voucherID == productInCartModel.voucherID) {
          //   productIncart.quantity =

          // }
        }
        if (!isExist) {
          listProductIncart.add(productInCartModel!);
        }
        savingCost = dataSnapshot['savingCost'] + savingCost;
      } else {
        listProductIncart.add(productInCartModel!);
      }

      int totalCost =
          CommonCaculatedMethods.caculateTotalCostInCart(listProductIncart);

      final data = {
        'productInCarts': listProductIncart,
        'totalCost': totalCost,
        'savingCost': savingCost,
        'userID': uid,
      };
      Cart c = Cart(
          productInCarts: listProductIncart,
          savingCost: savingCost,
          totalCost: totalCost,
          userID: uid);
      await cartDocs.update(c.toJson());
      // await transaction.update(cartDocs, data);
      // });
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteProductInCartModel(
      {required String uid,
      ProductInCartModel? productInCartModel,
      int savingCost = 0}) async {
    try {
      final querySnapshot = _firestore.collection('carts').get();
      final cartDocs = _firestore.collection('carts').doc(uid);
      // _firestore.runTransaction((transaction) async {
      //   DocumentSnapshot documentSnapshot = await transaction.get(cartDocs);
      final cartSnapshot = await cartDocs.get();
      final dataSnapshot = cartSnapshot.data();
      List<ProductInCartModel> listProductIncart = [];
      int realSavingCost = 0;
      if (dataSnapshot!['productInCarts'] != null) {
        listProductIncart = (dataSnapshot['productInCarts'] as List<dynamic>)
            .map((e) => ProductInCartModel.fromJson(e))
            .toList();
        realSavingCost = dataSnapshot['savingCost'] - savingCost;
      }
      listProductIncart
          .removeWhere((element) => element.id == productInCartModel!.id);

      int totalCost =
          CommonCaculatedMethods.caculateTotalCostInCart(listProductIncart);

      final data = {
        'productInCarts': listProductIncart,
        'totalCost': totalCost,
        'savingCost': realSavingCost,
        'userID': uid,
      };
      Cart c = Cart(
          productInCarts: listProductIncart,
          savingCost: savingCost,
          totalCost: totalCost,
          userID: uid);
      await cartDocs.update(c.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Cart?> getCartByUserID(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('carts')
          .where('userID', isEqualTo: uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs[0].data();

        return Cart.fromJson(data);
      } else {
        Cart c = Cart(userID: uid, productInCarts: []);
        await addCart(c);
        return c;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<Cart?> getCartByUser(String uid) async* {
    try {
      final ref = _firestore
          .collection('carts')
          .where('userID', isEqualTo: uid)
          .snapshots();
      StreamController<Cart?> streamController = StreamController<Cart?>();
      StreamSubscription streamSubscription = ref.listen((event) async {
        Cart? cart;
        if (event.docs.isNotEmpty) {
          final data = event.docs[0].data();
          cart = Cart.fromJson(data);
          // cart = Cart(
          //     userID: data.id,
          //     productInCarts: data.data()['productInCarts'] != null
          //         ? (data.data()['productInCarts'] as List)
          //             .map((e) => ProductInCartModel.fromJson(e))
          //             .toList()
          //         : null,
          //     savingCost: data.data()['savingCost'],
          //     totalCost: data.data()['totalCost']);
        } else {
          cart = Cart(userID: uid);
          await addCart(cart);
        }
        streamController.sink.add(cart);
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // category
  Future<void> addCategory(Category category) async {
    await _firestore
        .collection('categories')
        .doc(category.id)
        .set(category.toJson());
  }

  Future<List<Category>> getListCategory() async {
    List<Category> result = [];
    final snapshot = await _firestore.collection('categories').get();
    for (var data in snapshot.docs) {
      Category category = Category(
          id: data.id, logo: data.data()['logo'], name: data.data()['name']);
      result.add(category);
    }
    return result;
  }

  // chat
  Future<void> addChat(Chat chat) async {
    await _firestore.collection('chats').doc(chat.id).set(chat.toJson());
  }

  // flashsale
  Future<void> addFlashSale(FlashSale flashSale) async {
    await _firestore
        .collection('flashsales')
        .doc(flashSale.id)
        .set(flashSale.toJson());
  }

  Future<List<FlashSale>?> getActiveFlashSales() async {
    try {
      List<FlashSale> list = [];
      final snapshot = await _firestore
          .collection('flashsales')
          .where('expDate', isGreaterThan: Timestamp.now())
          .get();
      for (var data in snapshot.docs) {
        FlashSale flashSale = FlashSale(
            coverImage: data.data()['coverImage'],
            discountPercent: data.data()['discountPercent'],
            expDate: data.data()['expDate'],
            id: data.id,
            name: data.data()['name'],
            releasedDate: data.data()['releasedDate']);
        list.add(flashSale);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // deliver services
  Future<void> addDeliverService(DeliverService deliverService) async {
    await _firestore
        .collection('deliverservices')
        .doc(deliverService.id)
        .set(deliverService.toJson());
  }

  Future<List<DeliverService>?> getDeliverServiceList() async {
    try {
      List<DeliverService> list = [];
      final snapshot = await _firestore.collection('deliverservices').get();
      for (var data in snapshot.docs) {
        DeliverService deliverService =
            DeliverService.fromJson({'id': data.id, ...data.data()});
        // final deliverServiceData = data.data();
        // DeliverService deliverService =
        //     DeliverService.fromJson(deliverServiceData);
        list.add(deliverService);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // voucher
  Future<void> addVoucher(Voucher voucher) async {
    await _firestore
        .collection('vouchers')
        .doc(voucher.id)
        .set(voucher.toJson());
  }

  Future<List<Voucher>?> getActivceVoucherList() async {
    try {
      List<Voucher> list = [];
      final snapshot = await _firestore
          .collection('vouchers')
          .where('expDate', isGreaterThan: Timestamp.now())
          .get();
      for (var data in snapshot.docs) {
        // final voucherData = data.data();

        Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
        list.add(voucher);
      }
      print("List here: ${list}");
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Voucher>?> getListVoucherByShop(String shopID) async {
    try {
      List<Voucher> list = [];
      final snapshot = await _firestore
          .collection('vouchers')
          .where('expDate', isGreaterThan: Timestamp.now())
          .where('shopID', isEqualTo: shopID)
          .get();
      for (var data in snapshot.docs) {
        final voucherData = data.data();
        Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
        list.add(voucher);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Voucher>?> getListVoucherByProduct(String productID) async {
    try {
      List<Voucher> list = [];
      final snapshot = await _firestore
          .collection('vouchers')
          .where('expDate', isGreaterThan: Timestamp.now())
          .where('productID', isEqualTo: productID)
          .get();
      for (var data in snapshot.docs) {
        final voucherData = data.data();
        Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
        list.add(voucher);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Voucher?> getVoucherByID(String id) async {
    try {
      final snapshot = await _firestore
          .collection('vouchers')
          .where('id', isEqualTo: id)
          .where('expDate', isGreaterThan: Timestamp.now())
          .get();
      for (var data in snapshot.docs) {
        final voucherData = data.data();
        Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
        return voucher;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // voucher for user
  Future<void> addVoucherForUser(VoucherForUser voucherForUser) async {
    await _firestore
        .collection('voucherForUsers')
        .doc(voucherForUser.userID)
        .set(voucherForUser.toJson());
  }

  Stream<VoucherForUser?> getListVoucherForUser(String uid) async* {
    try {
      final ref = _firestore
          .collection('voucherForUsers')
          .where('userID', isEqualTo: uid)
          .snapshots();
      StreamController<VoucherForUser> streamController =
          StreamController<VoucherForUser>();
      StreamSubscription subscription = ref.listen((event) {
        for (var data in event.docs) {
          VoucherForUser voucher = VoucherForUser(
              userID: data.data()['userID'],
              vouchers: data.data()['vouchers'] != null
                  ? (data.data()['vouchers'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null);
          streamController.sink.add(voucher);
        }
      });
      streamController.onCancel = () {
        subscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // review section
  Future<void> addNewreview(Review review) async {
    await _firestore.collection('reviews').doc(review.id).set(review.toJson());
    //update to product
    final querySnapshotProducts = _firestore.collection('products').get();
    final productDocs = _firestore.collection('products').doc(review.productID);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot = await transaction.get(productDocs);
      final productSnapshot = await productDocs.get();
      var dataSnapshot = productSnapshot.data();
      List<String> listReview = [];
      if (dataSnapshot != null) {
        listReview =
            (dataSnapshot as List<dynamic>).map((e) => e.toString()).toList();
      }
      listReview.add(review.id!);
      final data = {
        "reviewIDs": FieldValue.arrayUnion([review.id!])
      };
      await transaction.update(productDocs, data);
    });
  }

  Stream<List<Review>?> getAllReviewByProduct(String productID) async* {
    try {
      final ref = _firestore
          .collection('reviews')
          .where('productID', arrayContains: productID)
          .snapshots();
      StreamController<List<Review>> streamController =
          StreamController<List<Review>>();
      StreamSubscription streamSubscription = ref.listen((event) {
        List<Review>? list = [];
        if (event.docs.isNotEmpty) {
          for (var data in event.docs) {
            Review review = Review(
                id: data.id,
                productID: data.data()['productID'],
                rating: data.data()['rating'],
                resourseType: data.data()['resourseType'],
                text: data.data()['text'],
                time: data.data()['time'],
                urlMedia: data.data()['urlMedia'],
                userAvatar: data.data()['userAvatar'],
                userID: data.data()['userID']);
            list.add(review);
          }
        } else {
          print("Empty");
        }
        streamController.sink.add(list);
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // currency section
  Future<List<CurrencyInfor>?> getListCurrencyInfor() async {
    try {
      List<CurrencyInfor> list = [];
      final snapshot = await _firestore.collection('currencyInfors').get();
      for (var data in snapshot.docs) {
        CurrencyInfor currencyInfor =
            CurrencyInfor.fromJson({'id': data.id, ...data.data()});
        list.add(currencyInfor);
      }
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> addNewCurrency(CurrencyInfor currencyInfor) async {
    try {
      await _firestore
          .collection('currencyInfors')
          .doc(currencyInfor.id)
          .set(currencyInfor.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteCurrencyInfor(String currencyID) async {
    try {
      // await _firestore
      //     .collection('currencyInfors')
      //     .doc(currencyInfor.id)
      //     .set(currencyInfor.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }
}
