import 'dart:async';

import 'package:dpl_ecommerce/const/app_decoration.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/cart.dart';
import 'package:dpl_ecommerce/models/category.dart';
import 'package:dpl_ecommerce/models/category_chart.dart';
import 'package:dpl_ecommerce/models/chat.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/currency_infor.dart';
import 'package:dpl_ecommerce/models/daily_revenue.dart';
import 'package:dpl_ecommerce/models/deliver_service.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/favourite_product.dart';
import 'package:dpl_ecommerce/models/flash_sale.dart';
import 'package:dpl_ecommerce/models/message.dart';
import 'package:dpl_ecommerce/models/order_shop.dart';
import 'package:dpl_ecommerce/models/ordering_product.dart';
import 'package:dpl_ecommerce/models/payment_type.dart';
import 'package:dpl_ecommerce/models/product.dart';
import 'package:dpl_ecommerce/models/product_in_cart_model.dart';
import 'package:dpl_ecommerce/models/review.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/models/voucher.dart';
import 'package:dpl_ecommerce/models/voucher_for_user.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/utils/common/common_caculated_methods.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/order_model.dart' as orderModel;

enum TypeOfTotalProduct { increase, decrease }

class FirestoreDatabase {
  FirestoreDatabase();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> dispose() async {
    await _firestore.terminate();
  }

  //products section
  // products
  Future<void> postProduct(Product product, String shopID) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id)
          .set(product.toJson());
      await updateTotalProductForShop(
          shopID: shopID, type: TypeOfTotalProduct.increase);
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getActiveProducts({int limit = 0}) async {
    try {
      List<Product> list = [];
      final snapshot = limit == 0
          ? await _firestore
              .collection('products')
              .where('availableQuantity', isGreaterThan: 0)
              .get()
          : await _firestore
              .collection('products')
              .where('availableQuantity', isGreaterThan: 0)
              .limit(limit)
              .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        Product product = Product.fromJson(productData);
        list.add(product);
      }
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListTopActiveProduct() async {
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
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
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
            Product product = Product.fromJson(data.data());
            // Product product = Product(
            //   id: data.id,
            //   availableQuantity: data.data()['availableQuantity'],
            //   categoryID: data.data()['categoryID'],
            //   description: data.data()['description'],
            //   colors: data.data()['colors'] != null
            //       ? (data.data()['colors'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   createdAt: data.data()['createdAt'],
            //   images: data.data()['images'] != null
            //       ? (data.data()['images'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   name: data.data()['name'],
            //   price: data.data()['price'],
            //   purchasingCount: data.data()['purchasingCount'],
            //   rating: data.data()['rating'],
            //   ratingCount: data.data()['ratingCount'],
            //   reviewIDs: data.data()['reviewIDs'] != null
            //       ? (data.data()['reviewIDs'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   shopID: data.data()['shopID'],
            //   shopLogo: data.data()['shopLogo'],
            //   shopName: data.data()['shopName'],
            //   sizes: data.data()['sizes'] != null
            //       ? (data.data()['sizes'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   types: data.data()['types'] != null
            //       ? (data.data()['types'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   updatedAt: data.data()['updatedAt'],
            //   videos: data.data()['videos'] != null
            //       ? (data.data()['videos'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   voucherID: data.data()['voucherID'],
            // );
            list.add(product);
          }
          list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          streamController.sink.add(list);
        } else {
          print("EMPTY");
          streamController.close();
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

  Future<List<Product>?> getListProductByShopID(String shopID) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('shopID', isEqualTo: shopID)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          final productData = data.data();
          Product product = Product.fromJson(productData);
          list.add(product);
        }
        list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        return list;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<Product>?> getAllProductByShopID(String shopID) async* {
    try {
      final ref = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('shopID', isEqualTo: shopID)
          .snapshots();
      StreamController<List<Product>?> streamController =
          StreamController<List<Product>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<Product>? list = [];
        if (event.docs.isNotEmpty) {
          for (var data in event.docs) {
            // final dataHere = data.data();
            //  Product p = Product.fromJson({'id': data.id, ...data.data()});
            Product product = Product.fromJson(data.data());
            // Product product = Product(
            //   id: data.id,
            //   availableQuantity: data.data()['availableQuantity'],
            //   categoryID: data.data()['categoryID'],
            //   description: data.data()['description'],
            //   colors: data.data()['colors'] != null
            //       ? (data.data()['colors'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   createdAt: data.data()['createdAt'],
            //   images: data.data()['images'] != null
            //       ? (data.data()['images'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   name: data.data()['name'],
            //   price: data.data()['price'],
            //   purchasingCount: data.data()['purchasingCount'],
            //   rating: data.data()['rating'],
            //   ratingCount: data.data()['ratingCount'],
            //   reviewIDs: data.data()['reviewIDs'] != null
            //       ? (data.data()['reviewIDs'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   shopID: data.data()['shopID'],
            //   shopLogo: data.data()['shopLogo'],
            //   shopName: data.data()['shopName'],
            //   sizes: data.data()['sizes'] != null
            //       ? (data.data()['sizes'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   types: data.data()['types'] != null
            //       ? (data.data()['types'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   updatedAt: data.data()['updatedAt'],
            //   videos: data.data()['videos'] != null
            //       ? (data.data()['videos'] as List<dynamic>)
            //           .map((e) => e.toString())
            //           .toList()
            //       : null,
            //   voucherID: data.data()['voucherID'],
            // );
            list.add(product);
          }
          list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          streamController.sink.add(list);
        } else {
          print("EMPTY");
          streamController.close();
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
        Product product = Product.fromJson(productSnapshot.data()!);
        // Product product = Product(
        //   id: productSnapshot.id,
        //   availableQuantity: productSnapshot.data()!['availableQuantity'],
        //   categoryID: productSnapshot.data()!['categoryID'],
        //   description: productSnapshot.data()!['description'],
        //   colors: productSnapshot.data()!['colors'] != null
        //       ? (productSnapshot.data()!['colors'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   createdAt: productSnapshot.data()!['createdAt'],
        //   images: productSnapshot.data()!['images'] != null
        //       ? (productSnapshot.data()!['images'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   name: productSnapshot.data()!['name'],
        //   price: productSnapshot.data()!['price'],
        //   purchasingCount: productSnapshot.data()!['purchasingCount'],
        //   rating: productSnapshot.data()!['rating'],
        //   ratingCount: productSnapshot.data()!['ratingCount'],
        //   reviewIDs: productSnapshot.data()!['reviewIDs'] != null
        //       ? (productSnapshot.data()!['reviewIDs'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   shopID: productSnapshot.data()!['shopID'],
        //   shopLogo: productSnapshot.data()!['shopLogo'],
        //   shopName: productSnapshot.data()!['shopName'],
        //   sizes: productSnapshot.data()!['sizes'] != null
        //       ? (productSnapshot.data()!['sizes'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   types: productSnapshot.data()!['types'] != null
        //       ? (productSnapshot.data()!['types'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   updatedAt: productSnapshot.data()!['updatedAt'],
        //   videos: productSnapshot.data()!['videos'] != null
        //       ? (productSnapshot.data()!['videos'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   voucherID: productSnapshot.data()!['voucherID'],
        // );
        return product;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> searchProductByName(String name) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        String productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListTopProduct() async {
    try {
      List<Product> list = [];
      // final snapshot = await _firestore
      //     .collection('products')
      //     .where('availableQuantity', isGreaterThan: 0);

      // QuerySnapshot snapshot1 = await _firestore
      //     .collection('products')

      //     .get();
      // Thực hiện hai truy vấn riêng biệt

      QuerySnapshot snapshot2 = await _firestore
          .collection('products')
          .where('rating', isGreaterThan: 4)
          .get();
      // QuerySnapshot snapshot3 = await _firestore
      //     .collection('products')
      //     .where('availableQuantity', isGreaterThan: 0)

      //     .get();
      // Điều kiện 2: purchaseCount > 10
      QuerySnapshot snapshot4 = await _firestore
          .collection('products')
          .where('purchasingCount', isGreaterThan: 10)
          .get();

      List<QueryDocumentSnapshot> combinedResults = [];

      // combinedResults.addAll(snapshot1.docs);
      combinedResults.addAll(snapshot2.docs);
      // combinedResults.addAll(snapshot3.docs);
      combinedResults.addAll(snapshot4.docs);

      // Lọc bản ghi trùng lặp (nếu có)
      Map<String, DocumentSnapshot> map = {};
      for (var doc in combinedResults) {
        map[doc.id] = doc;
      }
      combinedResults = map.values.toList().cast<QueryDocumentSnapshot>();

      // Xử lý dữ liệu trong combinedResults
      for (var element in combinedResults) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        Product p = Product.fromJson(data);
        if (p.availableQuantity! > 0) {
          list.add(p);
        }
      }
      // list = combinedResults.map((DocumentSnapshot doc) {
      //   Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      //   // Chuyển đổi dữ liệu thành đối tượng Product hoặc xử lý dữ liệu theo ý muốn
      //   return Product.fromJson(data);
      // }).toList();

      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListDealOfTheDay() async {
    try {
      List<Voucher>? listVoucher = await getActivceVoucherList();
      if (listVoucher != null && listVoucher.isNotEmpty) {
        List<Product> listProduct = [];
        for (var element in listVoucher) {
          if (element.productID != null) {
            Product? product = await getProductByID(element.productID!);
            if (product != null) {
              listProduct.add(product);
            }
          }
        }
        return listProduct;
      } else {
        print("Empty voucher");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListTopProductByShop(String shopID) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('shopID', isEqualTo: shopID)
          .get();

      QuerySnapshot snapshot1 = await _firestore
          .collection('products')
          // .where('availableQuantity', isGreaterThan: 0)
          .where('shopID', isEqualTo: shopID)
          .where('rating', isGreaterThan: 4)
          // .where('ratingCount', isGreaterThanOrEqualTo: 5)
          .get();

      // Điều kiện 2: purchaseCount > 50
      QuerySnapshot snapshot2 = await _firestore
          .collection('products')
          .where('shopID', isEqualTo: shopID)
          // .where('availableQuantity', isGreaterThan: 0)
          .where('purchasingCount', isGreaterThan: 10)
          .get();

// Kết hợp kết quả của cả hai truy vấn
      List<QueryDocumentSnapshot> combinedResults = [];
      combinedResults.addAll(snapshot1.docs);
      combinedResults.addAll(snapshot2.docs);

      Map<String, DocumentSnapshot> map = {};
      for (var doc in combinedResults) {
        map[doc.id] = doc;
      }
      combinedResults = map.values.toList().cast<QueryDocumentSnapshot>();

      // Xử lý dữ liệu trong combinedResults
      for (var element in combinedResults) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        Product p = Product.fromJson(data);
        if (p.availableQuantity! > 0) {
          list.add(p);
        }
      }

      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
      // for (var data in snapshot.docs) {
      //   final productData = data.data();
      //   Product product = Product.fromJson(productData);
      //   list.add(product);
      // }
      // list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      // return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> searchProductByNameAndRating(
      {required String name, required double rating}) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('rating', isGreaterThanOrEqualTo: rating)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        String productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> searchProductByNameAndPriceRange(
      {required String name,
      required int minPrice,
      required int maxPrice}) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        String productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> searchProductByNameAndNewestProduct(
      {required String name, required DateTime dateTime}) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('updatedAt', isLessThanOrEqualTo: Timestamp.fromDate(dateTime))
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        String productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> searchProductByNameAndCategory(
      {required String name, required String categoryID}) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('categoryID', isEqualTo: categoryID)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();
        String productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // Future<List<Product>?> filterMixedConditions({
  //   String? name,
  //   String? categoryID,
  //   int? minPrice,
  //   int? maxPrice,
  //   DateTime? dateTime,
  //   double? rating,
  // }) async {
  //   try {
  //     List<Product> list = [];

  //     var query = _firestore
  //         .collection('products')
  //         .where('availableQuantity', isGreaterThan: 0);

  //     // Lọc theo khoảng giá
  //     if (minPrice != null) {
  //       query = query.where('price', isGreaterThanOrEqualTo: minPrice);
  //     }
  //     if (maxPrice != null) {
  //       query = query.where('price', isLessThanOrEqualTo: maxPrice);
  //     }

  //     // Lọc theo rating
  //     if (rating != null) {
  //       query = query.where('rating', isGreaterThanOrEqualTo: rating);
  //     }

  //     // Lọc theo ngày đăng
  //     if (dateTime != null) {
  //       query = query.where('updatedAt',
  //           isLessThanOrEqualTo: Timestamp.fromDate(dateTime));
  //     }

  //     // Lọc theo thể loại
  //     if (categoryID != null && categoryID.isNotEmpty) {
  //       query = query.where('categoryID', isEqualTo: categoryID);
  //     }

  //     // Thực hiện truy vấn
  //     final snapshot = await query.get();

  //     for (var data in snapshot.docs) {
  //       final productData = data.data();
  //       final productName = productData['name'].toString().toLowerCase();
  //       if (productName.contains(name!.toLowerCase())) {
  //         Product product = Product.fromJson(productData);
  //         list.add(product);
  //       }
  //     }
  //     list.sort((a, b) => a.name!.compareTo(b.name!));
  //     list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
  //     return list;
  //   } catch (e) {
  //     print("An error occurred: $e");
  //   }
  // }
  Future<List<Product>?> filterMixedConditions({
    String? name,
    String? categoryID,
    int? minPrice,
    int? maxPrice,
    DateTime? dateTime,
    double? rating,
  }) async {
    try {
      List<Product> list = [];

      var query = _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0);

      // Lọc theo rating
      // if (rating != null) {
      //   query = query.where('rating', isGreaterThanOrEqualTo: rating);
      // }

      // // Lọc theo ngày đăng
      // if (dateTime != null) {
      //   query = query.where('updatedAt',
      //       isLessThanOrEqualTo: Timestamp.fromDate(dateTime));
      // }

      // // Lọc theo thể loại
      // if (categoryID != null && categoryID.isNotEmpty) {
      //   query = query.where('categoryID', isEqualTo: categoryID);
      // }

      // Thực hiện truy vấn
      final snapshot = await query.get();

      for (var data in snapshot.docs) {
        final productData = data.data();
        final productName = productData['name'].toString().toLowerCase();
        if (productName.contains(name!.toLowerCase())) {
          Product product = Product.fromJson(productData);
          list.add(product);
        }
      }

      // Filter by price on the client side
      if (minPrice != null && maxPrice != null) {
        list = list.where((product) {
          final price = product.price ?? 0;
          return (price >= minPrice) && (price <= maxPrice);
        }).toList();
      }
      if (categoryID != null) {
        list = list.where((product) {
          final category = product.categoryID;
          return (category == categoryID);
        }).toList();
      }
      if (rating != null && rating != 0.0) {
        list = list.where((product) {
          final ratingProduct = product.rating;
          return (ratingProduct! >= rating);
        }).toList();
      }

      // Sort the final list
      list.sort((a, b) => a.name!.compareTo(b.name!));
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

      return list;
    } catch (e) {
      print("An error occurred: $e");
      // Handle the error appropriately
    }
  }

  Future<void> deleteProduct(
      {required String productID, required String shopID}) async {
    try {
      await _firestore.collection('products').doc(productID).delete();
      updateTotalProductForShop(
          shopID: shopID, type: TypeOfTotalProduct.decrease);
    } catch (e) {
      print("An error occurred: $e");
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
    String? name,
  }) async {
    try {
      final doc = _firestore.collection('products').doc(productID);
      final ref = await doc.get();
      if (ref.exists) {
        final productData = ref.data();
        Product product = Product.fromJson(productData!);
        if (sizes != null) {
          product.sizes = sizes;
        }
        if (videos != null) {
          product.videos = videos;
        }
        if (colors != null) {
          product.colors = colors;
        }
        if (description != null) {
          product.description = description;
        }

        if (images != null) {
          product.images = images;
        }
        if (types != null) {
          product.types = types;
        }
        if (quantity != null) {
          product.availableQuantity = quantity;
        }
        if (cost != null) {
          product.price = cost;
        }
        if (name != null) {
          product.name = name;
        }
        product.updatedAt = Timestamp.now();
        await doc.update(product.toJson());
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Future<void> buyAProduct(String productID, int number) async {
    try {
      final doc = _firestore.collection('products').doc(productID);
      final ref = await doc.get();
      if (ref.exists) {
        final productData = ref.data();
        Product product = Product.fromJson(productData!);
        product.availableQuantity = product.availableQuantity! - number;
        product.purchasingCount++;
        await doc.update(product.toJson());
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

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
        Product product = Product.fromJson(data.data());
        // Product product = Product(
        //   id: data.id,
        //   availableQuantity: data.data()['availableQuantity'],
        //   categoryID: data.data()['categoryID'],
        //   description: data.data()['description'],
        //   colors: data.data()['colors'] != null
        //       ? (data.data()['colors'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   createdAt: data.data()['createdAt'],
        //   images: data.data()['images'] != null
        //       ? (data.data()['images'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   name: data.data()['name'],
        //   price: data.data()['price'],
        //   purchasingCount: data.data()['purchasingCount'],
        //   rating: data.data()['rating'],
        //   ratingCount: data.data()['ratingCount'],
        //   reviewIDs: data.data()['reviewIDs'] != null
        //       ? (data.data()['reviewIDs'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   shopID: data.data()['shopID'],
        //   shopLogo: data.data()['shopLogo'],
        //   shopName: data.data()['shopName'],
        //   sizes: data.data()['sizes'] != null
        //       ? (data.data()['sizes'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   types: data.data()['types'] != null
        //       ? (data.data()['types'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   updatedAt: data.data()['updatedAt'],
        //   videos: data.data()['videos'] != null
        //       ? (data.data()['videos'] as List<dynamic>)
        //           .map((e) => e.toString())
        //           .toList()
        //       : null,
        //   voucherID: data.data()['voucherID'],
        // );
        list.add(product);
      }
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
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
          Product product = Product.fromJson(data.data());
          // Product(
          //   id: data.id,
          //   availableQuantity: data.data()['availableQuantity'],
          //   categoryID: data.data()['categoryID'],
          //   description: data.data()['description'],
          //   colors: data.data()['colors'] != null
          //       ? (data.data()['colors'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   createdAt: data.data()['createdAt'],
          //   images: data.data()['images'] != null
          //       ? (data.data()['images'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   name: data.data()['name'],
          //   price: data.data()['price'],
          //   purchasingCount: data.data()['purchasingCount'],
          //   rating: data.data()['rating'],
          //   ratingCount: data.data()['ratingCount'],
          //   reviewIDs: data.data()['reviewIDs'] != null
          //       ? (data.data()['reviewIDs'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   shopID: data.data()['shopID'],
          //   shopLogo: data.data()['shopLogo'],
          //   shopName: data.data()['shopName'],
          //   sizes: data.data()['sizes'] != null
          //       ? (data.data()['sizes'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   types: data.data()['types'] != null
          //       ? (data.data()['types'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   updatedAt: data.data()['updatedAt'],
          //   videos: data.data()['videos'] != null
          //       ? (data.data()['videos'] as List<dynamic>)
          //           .map((e) => e.toString())
          //           .toList()
          //       : null,
          //   voucherID: data.data()['voucherID'],
          // );
          list.add(product);
        }
        list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListProductByCategory(String categoryID) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('categoryID', isEqualTo: categoryID)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();

        Product product = Product.fromJson(productData);
        list.add(product);
      }
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Product>?> getListProductByCategoryAndShop(
      {required String categoryID, required String shopID}) async {
    try {
      List<Product> list = [];
      final snapshot = await _firestore
          .collection('products')
          .where('availableQuantity', isGreaterThan: 0)
          .where('categoryID', isEqualTo: categoryID)
          .where('shopID', isEqualTo: shopID)
          .get();
      for (var data in snapshot.docs) {
        final productData = data.data();

        Product product = Product.fromJson(productData);
        list.add(product);
      }
      list.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // shop sections
  Future<void> addShop(Shop shop) async {
    try {
      await _firestore.collection('shops').doc(shop.id).set(shop.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateLegalInfo(
      {required String sellerID,
      required String taxPaper,
      required String lienceseNo,
      required String phone}) async {
    try {
      final userDoc = _firestore.collection('users').doc(sellerID);
      final ref = await userDoc.get();
      if (ref.exists) {
        final data = ref.data();
        UserModel seller = UserModel.fromJson(data!);
        seller.userInfor!.sellerInfor!.licenseNo = lienceseNo;
        seller.userInfor!.sellerInfor!.taxPaper = taxPaper;
        if (seller.phone != null) {
          seller.phone = phone;
        }
        await userDoc.update(seller.toJson());
      } else {
        print("Not exist");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> sendVerificationForm(
      {required VerificationForm verificationForm}) async {
    try {
      await _firestore
          .collection('verificationForms')
          .doc(verificationForm.shopID)
          .set(verificationForm.toJson());
      await updateLegalInfo(
          sellerID: verificationForm.sellerID!,
          lienceseNo: verificationForm.licenseNo!,
          taxPaper: verificationForm.taxPaper!,
          phone: verificationForm.phoneNumber!);
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // not yet
  Future<void> updateShopView(String shopID) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final ref = await shopDoc.get();
      if (ref.exists) {
        final data = ref.data();
        int shopView = data!['shopView'];
        shopView++;
        await shopDoc.update({'shopView': shopView});
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateTotalProductForShop(
      {required String shopID, required TypeOfTotalProduct type}) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final snapshot = await shopDoc.get();
      if (snapshot.exists) {
        final shopData = snapshot.data();
        Shop shop = Shop.fromJson(shopData!);
        if (type == TypeOfTotalProduct.increase) {
          shop.totalProduct++;
        } else {
          shop.totalProduct--;
        }

        await shopDoc.update(shop.toJson());
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<CategoryChart>?> getTotalProductOfEachCategoryByShop(
      String shopID) async {
    try {
      List<Category>? listCategory = await getListCategory();
      List<Product>? listProduct = await getActiveProducts();
      if (listCategory != null && listCategory!.isNotEmpty) {
        if (listProduct != null && listProduct.isNotEmpty) {
          List<CategoryChart> list = [];
          for (var category in listCategory) {
            int total = 0;
            for (var product in listProduct) {
              if (product.shopID == shopID &&
                  product.categoryID == category.id) {
                total++;
              }
            }
            CategoryChart categoryChart = CategoryChart(category.name!, total);
            list.add(categoryChart);
          }
          return list;
        }
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Shop>?> searchShopByName(String name) async {
    try {
      List<Shop> list = [];
      final snapshot = await _firestore.collection('shops').get();
      for (var data in snapshot.docs) {
        final shopData = data.data();
        String shopName = shopData['name'].toString().toLowerCase();
        if (shopName.contains(name.toLowerCase())) {
          Shop shop = Shop.fromJson(shopData);
          list.add(shop);
        }
      }
      list.sort((a, b) => a.name!.compareTo(b.name!));
      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateTotalOrderForShop({required String shopID}) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final snapshot = await shopDoc.get();
      if (snapshot.exists) {
        final shopData = snapshot.data();
        Shop shop = Shop.fromJson(shopData!);

        shop.totalOrder++;
        await shopDoc.update(shop.toJson());
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateTotalRevenueForShop(
      {required String shopID, required int revenue}) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final snapshot = await shopDoc.get();
      if (snapshot.exists) {
        final shopData = snapshot.data();
        Shop shop = Shop.fromJson(shopData!);

        shop.totalRevenue = shop.totalRevenue + revenue;
        await shopDoc.update(shop.toJson());
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateRatingCountForShop(
      {required String shopID, required double rating}) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final snapshot = await shopDoc.get();
      if (snapshot.exists) {
        final shopData = snapshot.data();
        Shop shop = Shop.fromJson(shopData!);
        shop.ratingCount = shop.ratingCount + 1;

        double newRating =
            (shop.rating * shop.ratingCount + rating) / (shop.ratingCount + 1);
        shop.rating = double.parse(newRating.toStringAsFixed(1));
        //  ratingCount
        await shopDoc.update(shop.toJson());
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateShop(
      {required String shopID,
      String? name,
      String? logo,
      int? rating,
      int? shopView,
      String? contactPhone,
      AddressInfor? addressInfor,
      String? shopDescription,
      int? totalProduct,
      int? totalOrder,
      int? totalRevenue}) async {
    try {
      final shopDoc = _firestore.collection('shops').doc(shopID);
      final snapshot = await shopDoc.get();
      if (snapshot.exists) {
        final shopData = snapshot.data();
        Shop shop = Shop.fromJson(shopData!);
        shop.logo = logo ?? shopData['logo'];
        shop.name = name ?? shopData['name'];
        shop.totalProduct = totalProduct ?? shopData['totalProduct'];
        shop.totalOrder = totalOrder ?? shopData['totalOrder'];
        shop.totalRevenue = totalRevenue ?? shopData['totalRevenue'];
        shop.addressInfor =
            addressInfor ?? AddressInfor.fromJson(shopData['addressInfor']);
        shop.shopDescription = shopDescription ?? shopData['shopDescription'];

        shop.rating = rating ?? shopData['rating'];
        shop.shopView = shopView ?? shopData['shopView'];
        shop.contactPhone = contactPhone ?? shopData['contactPhone'];
        await shopDoc.update(shop.toJson());
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Shop?> getSHopByID(String id) async {
    try {
      final ref = await _firestore.collection('shops').doc(id).get();
      if (ref.exists) {
        final data = ref.data();
        return Shop(
            addressInfor: AddressInfor.fromJson(data!['addressInfor']),
            contactPhone: data['contactPhone'],
            id: data['id'],
            logo: data['logo'],
            name: data['name'],
            rating: data['rating'],
            ratingCount: data['ratingCount'],
            shopDescription: data['shopDescription'],
            shopView: data['shopView'],
            totalProduct: data['totalProduct'],
            totalRevenue: data['totalRevenue'],
            totalOrder: data['totalOrder']);
      } else {
        print("Not exists");
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
        Shop shop = Shop.fromJson(data.data());
        // Shop(
        //   id: data.id,
        //   logo: data.data()['logo'],
        //   name: data.data()['name'],
        //   addressInfor: AddressInfor.fromJson(data.data()['addressInfor']),
        //   contactPhone: data.data()['contactPhone'],
        //   rating: (data.data()['rating'] as double),
        //   ratingCount: data.data()['ratingCount'],
        //   shopDescription: data.data()['shopDescription'],
        //   shopView: data.data()['shopView'],
        //   totalProduct: data.data()['totalProduct'],
        //   totalRevenue: data['totalRevenue'],
        //   totalOrder: data['totalOrder'],
        // );
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
              if (productInCartModel.type == productIncart.type) {
                if (productIncart.size == productInCartModel.size) {
                  if (productInCartModel.cost == productIncart.cost) {
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

  Future<void> deleteByProductInCartModelID(
      {required String uid,
      String? productInCartModelID,
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
          .removeWhere((element) => element.id == productInCartModelID);

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
    } catch (e) {}
  }

  // chat section
  Future<void> addChat(Chat chat) async {
    try {
      await _firestore.collection('chats').doc(chat.id).set(chat.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<Chat>?> getAllChatByUser(String uid) async* {
    try {
      final ref = _firestore
          .collection('chats')
          .where('userID', isEqualTo: uid)
          .snapshots();
      final StreamController<List<Chat>?> streamController =
          StreamController<List<Chat>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<Chat>? list = [];
        if (event.docs.isNotEmpty) {
          for (var data in event.docs) {
            Chat c = Chat.fromJson(data.data());
            // Chat(
            //     id: data.data()['id'],
            //     lastChatType: ChatType.values.firstWhere((element) =>
            //         element.toString().split(".").last ==
            //         data.data()['lastChatType']),
            //     lastMessage: data.data()['lastMessage'],
            //     listMsg: data.data()['listMsg'] != null
            //         ? (data.data()['listMsg'] as List)
            //             .map((e) => Message.fromJson(e))
            //             .toList()
            //         : null,
            //     sellerID: data.data()['sellerID'],
            //     shopID: data.data()['shopID'],
            //     shopLogo: data.data()['shopLogo'],
            //     shopName: data.data()['shopName'],
            //     userAvatar: data.data()['userAvatar'],
            //     userID: data.data()['userID'],
            //     userName: data.data()['userName']);
            list.add(c);
          }
        } else {
          print("Empty");
          streamController.close();
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

  Stream<List<Message>?> getListMsgInAChatByID(String id) async* {
    try {
      final ref = _firestore.collection('chats').doc(id).snapshots();
      final StreamController<List<Message>?> streamController =
          StreamController<List<Message>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<Message>? list = [];
        if (event.exists) {
          final data = event.data()!['listMsg'] as List<dynamic>;
          list = data.map((e) => Message.fromJson(e)).toList();
          // Chat c = Chat(
          //     id: data.data()['id'],
          //     lastChatType: data.data()['lastChatType'],
          //     lastMessage: data.data()['lastMessage'],
          //     listMsg: data.data()['listMsg'] != null
          //         ? (data.data()['listMsg'] as List)
          //             .map((e) => Message.fromJson(e))
          //             .toList()
          //         : null,
          //     sellerID: data.data()['sellerID'],
          //     shopID: data.data()['shopID'],
          //     shopLogo: data.data()['shopLogo'],
          //     shopName: data.data()['shopName'],
          //     userAvatar: data.data()['userAvatar'],
          //     userID: data.data()['userID'],
          //     userName: data.data()['userName']);
          // list.add(c);
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

  Stream<Chat?> getChatDataByID(String id) async* {
    try {
      final ref = _firestore.collection('chats').doc(id).snapshots();
      final StreamController<Chat?> streamController =
          StreamController<Chat?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<Message>? list = [];
        if (event.exists) {
          // final data = event.data()!['listMsg'] as List<dynamic>;
          // list = data.map((e) => Message.fromJson(e)).toList();
          Chat c = Chat.fromJson(event.data()!);
          // Chat(
          //   id: event.data()!['id'],
          //   lastChatType: ChatType.values.firstWhere((element) =>
          //       element.toString().split(".").last ==
          //       event.data()!['lastChatType']),
          //   lastMessage: event.data()!['lastMessage'],
          //   listMsg: event.data()!['listMsg'] != null
          //       ? (event.data()!['listMsg'] as List)
          //           .map((e) => Message.fromJson(e))
          //           .toList()
          //       : null,
          //   sellerID: event.data()!['sellerID'],
          //   shopID: event.data()!['shopID'],
          //   shopLogo: event.data()!['shopLogo'],
          //   shopName: event.data()!['shopName'],
          //   userAvatar: event.data()!['userAvatar'],
          //   userID: event.data()!['userID'],
          //   userName: event.data()!['userName'],
          // );
          // list.add(c);
          streamController.sink.add(c);
        } else {
          print("Empty");
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

  Future<Chat?> getChatByID(String id) async {
    try {
      final ref = await _firestore.collection('chats').doc(id).get();
      if (ref.exists) {
        Chat c = Chat.fromJson(ref.data()!);
        // Chat(
        //     id: ref.data()!['id'],
        //     lastChatType: ChatType.values.firstWhere((element) =>
        //         element.toString().split(".").last ==
        //         ref.data()!['lastChatType']),
        //     lastMessage: ref.data()!['lastMessage'],
        //     listMsg: ref.data()!['listMsg'] != null
        //         ? (ref.data()!['listMsg'] as List)
        //             .map((e) => Message.fromJson(e))
        //             .toList()
        //         : null,
        //     sellerID: ref.data()!['sellerID'],
        //     shopID: ref.data()!['shopID'],
        //     shopLogo: ref.data()!['shopLogo'],
        //     shopName: ref.data()!['shopName'],
        //     userAvatar: ref.data()!['userAvatar'],
        //     userID: ref.data()!['userID'],
        //     userName: ref.data()!['userName']);
        return c;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Chat?> getChatWithShop(
      {required String userID, required String shopID}) async {
    try {
      final ref = await _firestore
          .collection('chats')
          .where('shopID', isEqualTo: shopID)
          .where('userID', isEqualTo: userID)
          .get();
      if (ref.docs.isNotEmpty) {
        Chat c = Chat.fromJson(ref.docs[0].data());
        // Chat(
        //     id: ref.docs[0].data()['id'],
        //     lastChatType: ChatType.values.firstWhere((element) =>
        //         element.toString().split(".").last ==
        //         ref.docs[0].data()['lastChatType']),
        //     lastMessage: ref.docs[0].data()['lastMessage'],
        //     listMsg: ref.docs[0].data()['listMsg'] != null
        //         ? (ref.docs[0].data()['listMsg'] as List)
        //             .map((e) => Message.fromJson(e))
        //             .toList()
        //         : null,
        //     sellerID: ref.docs[0].data()['sellerID'],
        //     shopID: ref.docs[0].data()['shopID'],
        //     shopLogo: ref.docs[0].data()['shopLogo'],
        //     shopName: ref.docs[0].data()['shopName'],
        //     userAvatar: ref.docs[0].data()['userAvatar'],
        //     userID: ref.docs[0].data()['userID'],
        //     userName: ref.docs[0].data()['userName']);
        return c;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<Chat?> getChatWithUsers(
      {required String userID, required String sellerID}) async {
    try {
      final ref = await _firestore
          .collection('chats')
          .where('sellerID', isEqualTo: sellerID)
          .where('userID', isEqualTo: userID)
          .get();
      if (ref.docs.isNotEmpty) {
        final data = ref.docs[0].data();
        Chat c = Chat.fromJson(data);
        // Chat(
        //     id: ref.docs[0].data()['id'],
        //     lastChatType: ref.docs[0].data()['lastChatType'] != null
        //         ? ChatType.values.firstWhere((element) =>
        //             element.toString().split(".").last ==
        //             ref.docs[0].data()['lastChatType'])
        //         : null,
        //     lastMessage: ref.docs[0].data()['lastMessage'],
        //     listMsg: ref.docs[0].data()['listMsg'] != null
        //         ? (ref.docs[0].data()['listMsg'] as List)
        //             .map((e) => Message.fromJson(e))
        //             .toList()
        //         : null,
        //     sellerID: ref.docs[0].data()['sellerID'],
        //     shopID: ref.docs[0].data()['shopID'],
        //     shopLogo: ref.docs[0].data()['shopLogo'],
        //     shopName: ref.docs[0].data()['shopName'],
        //     userAvatar: ref.docs[0].data()['userAvatar'],
        //     userID: ref.docs[0].data()['userID'],
        //     userName: ref.docs[0].data()['userName']);
        return c;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<bool?> checkExistedChatBox(String id) async {
    try {
      final ref = await _firestore.collection('chats').doc(id).get();
      if (ref.exists) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<bool?> checkExistedChatBoxWithUsers(
      {required String userID, required String sellerID}) async {
    try {
      final ref = await _firestore
          .collection('chats')
          .where('sellerID', isEqualTo: sellerID)
          .where('userID', isEqualTo: userID)
          .get();
      if (ref.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<bool?> checkExistedChatBoxWithShop(
      {required String userID, required String shopID}) async {
    try {
      final ref = await _firestore
          .collection('chats')
          .where('shopID', isEqualTo: shopID)
          .where('userID', isEqualTo: userID)
          .get();
      if (ref.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> sendAMessage(
      {required String chatID, required Message msg}) async {
    try {
      final CollectionReference collectionReference =
          _firestore.collection('chats');
      final DocumentReference chatDoc = collectionReference.doc(chatID);

      Chat? chat = await getChatByID(chatID);
      chat!.listMsg!.add(msg);
      chat.lastMessage = msg.content;
      chat.lastChatType = msg.chatType;
      final data = chat.toJson();
      await chatDoc.update(data);
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // get chat list seller side
  Stream<List<Chat>?> getAllChatBySellerID(String uid) async* {
    try {
      final ref = _firestore
          .collection('chats')
          .where('sellerID', isEqualTo: uid)
          .snapshots();
      final StreamController<List<Chat>?> streamController =
          StreamController<List<Chat>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<Chat>? list = [];
        if (event.docs.isNotEmpty) {
          print("Chat lenght: ${event.docs.length}");
          for (var data in event.docs) {
            print("data dot data: ${data.data()}");
            Chat c = Chat.fromJson(data.data());
            //  Chat(
            //     id: data.data()['id'],
            //     lastChatType: ChatType.values.firstWhere((element) =>
            //         element.toString().split(".").last ==
            //         data.data()['lastChatType']),
            //     lastMessage: data.data()['lastMessage'],
            //     listMsg: data.data()['listMsg'] != null
            //         ? (data.data()['listMsg'] as List)
            //             .map((e) => Message.fromJson(e))
            //             .toList()
            //         : null,
            //     sellerID: data.data()['sellerID'],
            //     shopID: data.data()['shopID'],
            //     shopLogo: data.data()['shopLogo'],
            //     shopName: data.data()['shopName'],
            //     userAvatar: data.data()['userAvatar'],
            //     userID: data.data()['userID'],
            //     userName: data.data()['userName']);
            list.add(c);
          }
        } else {
          print("Empty");
          // streamController.close();
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

  Future<List<FlashSale>?> getActiveFlashSales() async {
    try {
      List<FlashSale> list = [];
      final snapshot = await _firestore
          .collection('flashsales')
          .where('expDate', isGreaterThan: Timestamp.now())
          .get();
      if (snapshot.docs.isNotEmpty) {
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
      } else {
        print("Empty");
      }

      return list;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // voucher section
  Future<void> addVoucher(Voucher voucher) async {
    try {
      await _firestore
          .collection('vouchers')
          .doc(voucher.id)
          .set(voucher.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> editVoucher(
      {required String id, required Voucher voucher}) async {
    try {
      final voucherDoc = _firestore.collection('vouchers').doc(id);
      final ref = await voucherDoc.get();
      if (ref.exists) {
        Voucher voucherInstance = Voucher.fromJson(ref.data()!);
        // Voucher(
        //     id: ref.data()![id],
        //     discountAmount: voucher.discountAmount,
        //     discountPercent: voucher.discountPercent,
        //     expDate: voucher.expDate,
        //     name: voucher.name,
        //     productID: voucher.productID,
        //     releasedDate: voucher.releasedDate,
        //     shopID: voucher.shopID,
        //     isAdmin: voucher.isAdmin);
        // voucherInstance.discountAmount = voucher.discountAmount;
        // voucherInstance.discountPercent = voucher.discountPercent;
        // voucherInstance.expDate = voucher.expDate;
        // voucherInstance.releasedDate = voucher.releasedDate;
        // vou
        await voucherDoc.update(voucher.toJson());
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteVoucherByID(String id) async {
    try {
      await _firestore.collection('vouchers').doc(id).delete();
      print('Voucher with ID $id has been deleted successfully.');
    } catch (e) {
      print("An error occured: $e");
    }
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

  Stream<List<Voucher>?> getAllVoucherByShop(String shopID) async* {
    try {
      final ref = _firestore
          .collection('vouchers')
          .where('shopID', isEqualTo: shopID)
          .snapshots();
      final streamController = StreamController<List<Voucher>?>();
      List<Voucher> list = [];
      final StreamSubscription streamSubscription = ref.listen((event) {
        list.clear();
        for (var data in event.docs) {
          final voucherData = data.data();
          Voucher voucherInstance = Voucher.fromJson(data.data());
          // Voucher(
          //     id: data.data()['id'],
          //     discountAmount: data.data()['discountAmount'],
          //     discountPercent: data.data()['discountPercent'],
          //     expDate: data.data()['expDate'],
          //     name: data.data()['name'],
          //     productID: data.data()['productID'],
          //     releasedDate: data.data()['releasedDate'],
          //     shopID: data.data()['shopID'],
          //     isAdmin: data.data()['isAdmin']);
          list.add(voucherInstance);
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

  Stream<List<Voucher>?> getAllVoucherByAdmin() async* {
    try {
      final ref = _firestore
          .collection('vouchers')
          .where('idAdmin', isEqualTo: true)
          .snapshots();
      final streamController = StreamController<List<Voucher>?>();
      List<Voucher> list = [];
      final StreamSubscription streamSubscription = ref.listen((event) {
        list.clear();
        for (var data in event.docs) {
          final voucherData = data.data();
          Voucher voucherInstance = Voucher.fromJson(data.data());
          // Voucher(
          //     id: data.data()['id'],
          //     discountAmount: data.data()['discountAmount'],
          //     discountPercent: data.data()['discountPercent'],
          //     expDate: data.data()['expDate'],
          //     name: data.data()['name'],
          //     productID: data.data()['productID'],
          //     releasedDate: data.data()['releasedDate'],
          //     shopID: data.data()['shopID'],
          //     isAdmin: data.data()['isAdmin']);
          list.add(voucherInstance);
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

  Future<List<Voucher>?> getListVoucherByAdmin() async {
    try {
      List<Voucher> list = [];
      final snapshot = await _firestore
          .collection('vouchers')
          // .where('expDate', isGreaterThan: Timestamp.now())
          .where('isAdmin', isEqualTo: true)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          final voucherData = data.data();
          Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
          list.add(voucher);
        }
        return list;
      } else {
        print("EMPTY");
      }
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
      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          final voucherData = data.data();
          Voucher voucher = Voucher.fromJson({'id': data.id, ...data.data()});
          list.add(voucher);
        }
        return list;
      } else {
        print("Empty");
      }
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
    try {
      await _firestore
          .collection('voucherForUsers')
          .doc(voucherForUser.userID)
          .set(voucherForUser.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<bool> isExistVoucherForUser(String uid) async {
    final ref = await _firestore.collection('voucherForUsers').doc(uid).get();
    return ref.exists;
  }

  Future<void> updateVoucherForUser(
      {required String userID, required String voucherID}) async {
    try {
      final voucherDoc = _firestore.collection("voucherForUsers").doc(userID);
      final voucherSnaphot = await voucherDoc.get();
      if (voucherSnaphot.exists) {
        final data = voucherSnaphot.data();
        final listVoucher = data!['vouchers'] as List<dynamic>;
        final vouchers = listVoucher.map((e) => e.toString()).toList();
        vouchers.add(voucherID);
        final newData = {
          'userID': userID,
          'vouchers': FieldValue.arrayUnion(vouchers)
        };
        await voucherDoc.update(newData);
      } else {
        addVoucherForUser(
            VoucherForUser(userID: userID, vouchers: [voucherID]));
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteVoucherIDForUser(
      {required String uid, required String voucherID}) async {
    try {
      final voucherDoc = _firestore.collection("voucherForUsers").doc(uid);
      final voucherSnaphot = await voucherDoc.get();
      if (voucherSnaphot.exists) {
        final data = voucherSnaphot.data();
        final listVoucher = data!['vouchers'] as List<dynamic>;
        final vouchers = listVoucher.map((e) => e.toString()).toList();
        if (vouchers.isNotEmpty) {
          for (var element in vouchers) {
            if (element == voucherID) {
              vouchers.remove(element);
            }
          }
        }
        final newData = {
          'userID': uid,
          'vouchers': FieldValue.arrayUnion(vouchers)
        };
        await voucherDoc.update(newData);
      } else {
        print("EMPTY");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<bool> isCollectedVoucher(
      {required String uid, required String voucherID}) async* {
    try {
      final ref = _firestore.collection('voucherForUsers').doc(uid).snapshots();
      final StreamController<bool> streamController = StreamController<bool>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        if (event.exists) {
          final data = event.data();
          VoucherForUser voucherForUser = VoucherForUser.fromJson(data!);
          bool isExist = false;
          if (voucherForUser.vouchers != null) {
            for (var element in voucherForUser.vouchers!) {
              if (element == voucherID) {
                isExist = true;
              }
            }
          }
          streamController.sink.add(isExist);
        } else {
          print("Not exists");
          streamController.close();
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

  Future<void> reviewAProduct(
      {required String productID,
      required String reviewID,
      required double rating}) async {
    try {
      final doc = _firestore.collection('products').doc(productID);
      final ref = await doc.get();
      if (ref.exists) {
        final productData = ref.data();
        Product product = Product.fromJson(productData!);
        product.reviewIDs ??= [];
        product.reviewIDs!.add(reviewID);
        if (product.ratingCount == 0) {
          product.ratingCount = 1;
          product.rating = rating;
        } else {
          product.ratingCount++;
          double newRating = (product.rating! * product.ratingCount + rating) /
              (product.ratingCount + 1);
          product.rating = double.parse(newRating.toStringAsFixed(1));
        }
        await doc.update(product.toJson());
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  Stream<VoucherForUser?> getListVoucherForUser(String uid) async* {
    try {
      final ref = _firestore.collection('voucherForUsers').doc(uid).snapshots();
      StreamController<VoucherForUser> streamController =
          StreamController<VoucherForUser>();
      StreamSubscription subscription = ref.listen((event) {
        // if (event.docs.isEmpty) {
        // for (var data in event.docs) {
        if (event.exists) {
          VoucherForUser voucher = VoucherForUser(
              userID: event.data()!['userID'],
              vouchers: event.data()!['vouchers'] != null
                  ? (event.data()!['vouchers'] as List<dynamic>)
                      .map((e) => e.toString())
                      .toList()
                  : null);
          streamController.sink.add(voucher);
        } else {
          print("Emmpty");
          streamController.close();
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

  Future<VoucherForUser?> getVoucherUser(String uid) async {
    try {
      final ref = await _firestore.collection('voucherForUsers').doc(uid).get();
      if (ref.exists) {
        return VoucherForUser.fromJson(ref.data()!);
      } else {
        VoucherForUser voucherForUser =
            VoucherForUser(userID: uid, vouchers: []);
        await addVoucherForUser(voucherForUser);
        print("EMPTY");
        return voucherForUser;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // review section
  Future<void> addNewReview(Review review) async {
    try {
      await _firestore
          .collection('reviews')
          .doc(review.id)
          .set(review.toJson());
      //update to product
      await reviewAProduct(
          productID: review.productID!,
          reviewID: review.id!,
          rating: review.rating!);

      // final querySnapshotProducts = _firestore.collection('products').get();
      // final productDocs = _firestore.collection('products').doc(review.productID);
      // FirebaseFirestore.instance.runTransaction((transaction) async {
      //   DocumentSnapshot documentSnapshot = await transaction.get(productDocs);
      //   final productSnapshot = await productDocs.get();
      //   var dataSnapshot = productSnapshot.data();
      //   List<String> listReview = [];
      //   if (dataSnapshot != null) {
      //     listReview =
      //         (dataSnapshot as List<dynamic>).map((e) => e.toString()).toList();
      //   }
      //   listReview.add(review.id!);

      //   final data = {
      //     "reviewIDs": FieldValue.arrayUnion([review.id!])
      //   };
      //   await transaction.update(productDocs, data);
      // });
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteReview(String reviewID) async {
    try {
      await _firestore.collection('reviews').doc(reviewID).delete();
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<Review>?> getListReviewByProduct(String productID) async {
    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where('productID', isEqualTo: productID)
          .get();
      if (snapshot.docs.isNotEmpty) {
        List<Review>? list = [];
        for (var data in snapshot.docs) {
          Review review = Review.fromJson(data.data());
          // Review(
          //     id: data.id,
          //     productID: data.data()['productID'],
          //     rating: data.data()['rating'],
          //     resourseType: data.data()['resourseType'] != null
          //         ? ResourseType.values.firstWhere((element) =>
          //             element.toString().split(".").last ==
          //             data.data()['resourseType'])
          //         : null,
          //     text: data.data()['text'],
          //     time: data.data()['time'],
          //     urlMedia: data.data()['urlMedia'],
          //     userAvatar: data.data()['userAvatar'],
          //     userID: data.data()['userID'],
          //     userName: data.data()['userName']);
          list.add(review);
        }
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<Review>?> getAllReviewByProduct(String productID) async* {
    try {
      print("object: ${productID}");
      final ref = _firestore
          .collection('reviews')
          .where('productID', isEqualTo: productID)
          .snapshots();
      StreamController<List<Review>> streamController =
          StreamController<List<Review>>();
      StreamSubscription streamSubscription = ref.listen((event) {
        List<Review>? list = [];
        if (event.docs.isNotEmpty) {
          for (var data in event.docs) {
            Review review = Review.fromJson(data.data());
            // Review review = Review(
            //     id: data.id,
            //     productID: data.data()['productID'],
            //     rating: data.data()['rating'],
            //     resourseType: data.data()['resourseType'] != null
            //         ? ResourseType.values.firstWhere((element) =>
            //             element.toString().split(".").last ==
            //             data.data()['resourseType'])
            //         : null,
            //     text: data.data()['text'],
            //     time: data.data()['time'],
            //     urlMedia: data.data()['urlMedia'],
            //     userAvatar: data.data()['userAvatar'],
            //     userID: data.data()['userID'],
            //     userName: data.data()['userName']);
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

  // favourite section
  Future<List<FavouriteProduct>?> getListFavouriteProduct(String uid) async {
    try {
      // await _firestore.runTransaction((Transaction transaction) async {
      List<FavouriteProduct>? list = [];
      final snapshot = await _firestore
          .collection('favouriteProducts')
          .where('userID', isEqualTo: uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          final productData = data.data();
          FavouriteProduct product = FavouriteProduct.fromJson(productData);
          // FavouriteProduct(
          //   createdAt: productData['createdAt'],
          //   id: data.id,
          //   productID: productData['productID'],
          //   userID: productData['userID'],
          // );
          list.add(product);
        }
        return list;
      } else {
        print("Empty");
      }
      // });
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<FavouriteProduct>?> getAllFavouriteProduct(String uid) async* {
    try {
      final ref = _firestore
          .collection('favouriteProducts')
          .where('userID', isEqualTo: uid)
          .snapshots();
      StreamController<List<FavouriteProduct>?> streamController =
          StreamController<List<FavouriteProduct>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<FavouriteProduct>? list = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            FavouriteProduct product =
                FavouriteProduct.fromJson(element.data());
            list.add(product);
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

  Future<void> addToFavourite(FavouriteProduct favouriteProduct) async {
    try {
      await _firestore
          .collection('favouriteProducts')
          .doc(favouriteProduct.id)
          .set(favouriteProduct.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<bool?> isFavouriteProduct(String uid, String productID) async* {
    try {
      final snapshot = await _firestore
          .collection('favouriteProducts')
          .where('userID', isEqualTo: uid)
          .where('productID', isEqualTo: productID)
          .snapshots();
      final StreamController<bool> streamController = StreamController<bool>();
      final StreamSubscription streamSubscription = snapshot.listen((event) {
        if (event.docs.isNotEmpty) {
          streamController.sink.add(true);
        } else {
          streamController.sink.add(false);
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

  Future<bool?> isFavourite(String uid, String productID) async {
    try {
      final snapshot = await _firestore
          .collection('favouriteProducts')
          .where('userID', isEqualTo: uid)
          .where('productID', isEqualTo: productID)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteFavouriteByParams(
      {required String uid, required String productID}) async {
    try {
      final snapshot = await _firestore
          .collection('favouriteProducts')
          .where('userID', isEqualTo: uid)
          .where('productID', isEqualTo: productID)
          .limit(1)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          String docID = element.id;
          await FirebaseFirestore.instance
              .collection('favouriteProducts')
              .doc(docID)
              .delete();
        }
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteFavourite(String id) async {
    try {
      await _firestore.collection('favouriteProducts').doc(id).delete();
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // order sections
  Future<List<orderModel.Order>?> getListOrderByUserID(String uid) async {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userID', isEqualTo: uid)
          .get();
      if (snapshot.docs.isNotEmpty) {
        List<orderModel.Order>? list = [];
        for (var element in snapshot.docs) {
          orderModel.Order order = orderModel.Order.fromJson(element.data());
          // orderModel.Order(
          //     deliverServiceID: element.data()['deliverServiceID'],
          //     // deliverStatus: element.data()['deliverStatus'],
          //     id: element.data()['id'],
          //     isCancelled: element.data()['isCancelled'],
          //     orderingProductsID: element.data()['orderingProductsID'] != null
          //         ? (element.data()['orderingProductsID'] as List<dynamic>)
          //             .map((e) {
          //             OrderingProduct o = OrderingProduct.fromJson(e);
          //             print("Nothing: ${o.quantity}");
          //             return o;
          //           }).toList()
          //         : null,
          //     paymentTypeID: element.data()['paymentTypeID'],
          //     receivedAddress:
          //         AddressInfor.fromJson(element.data()['receivedAddress']),
          //     shippingCost: element.data()['shippingCost'] ?? 0,
          //     totalCost: element.data()['totalCost'],
          //     userID: element.data()['userID'],
          //     voucherDiscountID: element.data()['voucherDiscountID'],
          //     totalProduct: element.data()['totalProduct'],
          //     time: (element.data()['time'] as Timestamp));
          List<OrderingProduct>? listO =
              element.data()['orderingProductsID'] != null
                  ? (element.data()['orderingProductsID'] as List)
                      .map((e) => OrderingProduct.fromJson(e))
                      .toList()
                  : null;
          print(listO);
          list.add(order);
        }
        for (var element in list) {
          for (var data in element.orderingProductsID!) {
            if (data.deliverStatus != DeliverStatus.delivered) {
              DateTime now = DateTime.now();
              DateTime time = data.date!.toDate();
              final difference = now.difference(time);
              if (difference.inHours > 4) {
                await updateOrderingProductStatus(
                    orderID: element.id!,
                    orderingProductID: data.id!,
                    status: DeliverStatus.delivering);
                await updateOrderShopStatusByOrderingProductID(
                    data.id!, DeliverStatus.delivering);
              }
              // else if (difference.inMinutes > 12) {
              //   await updateOrderingProductStatus(
              //       orderID: element.id!,
              //       orderingProductID: data.id!,
              //       status: DeliverStatus.confirmed);
              // } else {}
            }
          }
        }
        list.sort((a, b) => b.time!.compareTo(a.time!));
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<orderModel.Order>?> getAllOrderByUserID(String uid) async* {
    try {
      final snapshot = await _firestore
          .collection('orders')
          .where('userID', isEqualTo: uid)
          .snapshots();
      final StreamController<List<orderModel.Order>?> streamController =
          StreamController<List<orderModel.Order>?>();
      final StreamSubscription streamSubscription = snapshot.listen((event) {
        List<orderModel.Order>? list = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            orderModel.Order order = orderModel.Order.fromJson(element.data());
            // orderModel.Order(
            //     deliverServiceID: element.data()['deliverServiceID'],
            //     // deliverStatus: element.data()['deliverStatus'],
            //     id: element.data()['id'],
            //     isCancelled: element.data()['isCancelled'],
            //     orderingProductsID: element.data()['orderingProductsID'] != null
            //         ? (element.data()['orderingProductsID'] as List)
            //             .map((e) => OrderingProduct.fromJson(e))
            //             .toList()
            //         : null,
            //     paymentTypeID: element.data()['paymentTypeID'],
            //     receivedAddress:
            //         AddressInfor.fromJson(element.data()['receivedAddress']),
            //     shippingCost: element.data()['shippingCost'] ?? 0,
            //     totalCost: element.data()['totalCost'],
            //     userID: element.data()['userID'],
            //     voucherDiscountID: element.data()['voucherDiscountID'],
            //     totalProduct: element.data()['totalProduct'],
            //     time: (element.data()['time'] as Timestamp));
            list.add(order);
          }
          list.sort((a, b) => b.time!.compareTo(a.time!));
          streamController.sink.add(list);
        } else {
          print("Empty");
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

  Future<bool> isReviewedByUserAndOrderingProduct(
      {required String orderingProductID, required String orderID}) async {
    try {
      final ref = await _firestore.collection('orders').doc(orderID).get();
      if (ref.exists) {
        final data = ref.data();
        final list = data!['orderingProductsID'];
        if (list != null) {
          final listProduct = (list as List<dynamic>)
              .map((e) => OrderingProduct.fromJson(e))
              .toList();

          for (var element in listProduct) {
            if (element.id == orderingProductID) {
              if (element.isReviewed) {
                return true;
              }
            }
          }
          return false;
        }
        return false;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
    return false;
  }

  Future<void> addAnOrder(orderModel.Order order) async {
    try {
      await _firestore.collection('orders').doc(order.id).set(order.toJson());
      for (var element in order.orderingProductsID!) {
        await buyAProduct(element.productID!, element.quantity!);
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateOrderingProductStatus(
      {required String orderID,
      required String orderingProductID,
      required DeliverStatus status}) async {
    try {
      final doc = _firestore.collection('orders').doc(orderID);
      final ref = await doc.get();
      if (ref.exists) {
        final data = ref.data();

        final listProduct = data!['orderingProductsID'] != null
            ? (data['orderingProductsID'] as List<dynamic>)
                .map((e) => OrderingProduct.fromJson(e))
                .toList()
            : null;
        if (listProduct != null) {
          for (var element in listProduct) {
            if (element.id == orderingProductID) {
              element.deliverStatus = status;
            }
          }
        }
        final updateData = {
          'orderingProductsID': listProduct?.map((e) => e.toJson()).toList(),
          // Cập nhật các trường khác cần thiết
          // ...
        };

        orderModel.Order order = orderModel.Order.fromJson(data);
        // orderModel.Order(
        //     deliverServiceID: data!['deliverServiceID'],
        //     id: data['id'],
        //     isCancelled: data['isCancelled'],
        //     orderingProductsID: listProduct,
        //     paymentTypeID: data['paymentTypeID'],
        //     receivedAddress: AddressInfor.fromJson(data['receivedAddress']),
        //     shippingCost: data['shippingCost'],
        //     totalCost: data['totalCost'],
        //     totalProduct: data['totalProduct'],
        //     userID: data['userID'],
        //     voucherDiscountID: data['voucherDiscountID'],
        //     time: (data['time'] as Timestamp));
        await doc.update(updateData);
        await updateOrderShopStatusByOrderingProductID(
            orderingProductID, status);
      } else {
        print("NOt exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<orderModel.Order?> getOrderByID(String id) async {
    try {
      final ref = await _firestore.collection('orders').doc(id).get();
      if (ref.exists) {
        final data = ref.data();
        return orderModel.Order.fromJson(data!);
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<OrderingProduct>?> getListOrderingProductByOrder(
      String orderID) async {
    try {
      final ref = await _firestore.collection('orders').doc(orderID).get();
      if (ref.exists) {
        final data = ref.data();
        orderModel.Order order = orderModel.Order.fromJson(data!);
        final list = order.orderingProductsID;
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<OrderingProduct?> getOrderingProductByOrderID(
      {required String orderID, required String orderingProductID}) async {
    try {
      final ref = await _firestore.collection('orders').doc(orderID).get();
      if (ref.exists) {
        final data = ref.data();
        orderModel.Order order = orderModel.Order.fromJson(data!);
        final list = order.orderingProductsID;
        if (list != null) {
          for (var element in list!) {
            if (element.id == orderingProductID) {
              return element;
            }
          }
        } else {
          print("null");
        }
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateRatingForProduct(
      String orderID, String orderingProductID) async {
    try {
      final orderDoc = _firestore.collection('orders').doc(orderID);
      final ref = await orderDoc.get();
      if (ref.exists) {
        orderModel.Order? order = orderModel.Order.fromJson(ref.data()!);
        final orderingProducts = order.orderingProductsID;
        // final list = orderingProducts != null
        //     ? (orderingProducts as List<dynamic>)
        //         .map((e) => OrderingProduct.fromJson(e))
        //         .toList()
        //     : null;
        if (orderingProducts != null) {
          for (var element in orderingProducts!) {
            if (element.id == orderingProductID) {
              element.isReviewed = true;
            }
          }
        }
        await orderDoc.update(order.toJson());
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // orderShop section
  Future<void> addOrderShop(OrderShop orderShop) async {
    try {
      await _firestore
          .collection('orderShops')
          .doc(orderShop.id)
          .set(orderShop.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<OrderShop>?> getListOrderByShop(String shopID) async {
    try {
      final ref = await _firestore
          .collection('orderShops')
          .where('shopID', isEqualTo: shopID)
          .get();
      if (ref.docs.isNotEmpty) {
        List<OrderShop> list = [];
        for (var element in ref.docs) {
          final data = element.data();
          OrderShop orderShop = OrderShop.fromJson(data);
          list.add(orderShop);
        }
        list.sort((a, b) => b.orderDate!.compareTo(a.orderDate!));
        return list;
      } else {
        print("EMPTy");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<OrderShop?> getOrderShopByID(String id) async {
    try {
      final ref = await _firestore.collection('orderShops').doc(id).get();
      if (ref.exists) {
        OrderShop orderShop = OrderShop.fromJson(ref.data()!);
        return orderShop;
      } else {
        print("EMpty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updatePaymentStatusForOrderShop(
      String orderShopID, PaymentStatus paymentStatus) async {
    try {
      final orderShopDoc =
          await _firestore.collection('orderShops').doc(orderShopID);
      final ref = await orderShopDoc.get();
      if (ref.exists) {
        final data = ref.data();
        if (data != null) {
          OrderShop orderShop = OrderShop.fromJson(data);
          orderShop.paymentStatus = paymentStatus;
          final newData = orderShop.toJson();
          await orderShopDoc.update(newData);
          await updateTotalOrderForShop(shopID: orderShop.id!);
          await updateTotalRevenueForShop(
              shopID: orderShop.shopID!, revenue: orderShop.totalPrice!);
        } else {
          print("Data is null");
        }
      } else {
        print("EMPTy");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> updateOrderShopStatusByOrderingProductID(
      String orderingProductID, DeliverStatus status) async {
    try {
      final orderShop = await _firestore
          .collection('orderShops')
          .where('orderingProductID', isEqualTo: orderingProductID)
          .get();
      if (orderShop.docs.isNotEmpty) {
        await _firestore
            .collection('orderShops')
            .doc(orderShop.docs[0].id)
            .update({'deliverStatus': status.toString().split(".").last});
      } else {
        print("EMPTY");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> confirmOrder(String orderShopID) async {
    try {
      final orderShopDoc =
          await _firestore.collection('orderShops').doc(orderShopID);
      final ref = await orderShopDoc.get();
      if (ref.exists) {
        final data = ref.data();
        if (data != null) {
          OrderShop orderShop = OrderShop.fromJson(data);
          orderShop.deliverStatus = DeliverStatus.confirmed;
          final newData = orderShop.toJson();
          await orderShopDoc.update(newData);
          await updateOrderingProductStatus(
              orderID: orderShop.orderCode!,
              orderingProductID: orderShop.orderingProductID!,
              status: DeliverStatus.confirmed);
        } else {
          print("Data is null");
        }
      } else {
        print("EMPTy");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // daily revenue section
  Future<List<DailyRevenue>?> getListDailyRevenueByShop(String shopID) async {
    try {
      final ref = await _firestore
          .collection('dailyRevenues')
          .where('shopID', isEqualTo: shopID)
          .get();
      if (ref.docs.isNotEmpty) {
        List<DailyRevenue> list = [];
        for (var element in ref.docs) {
          final data = element.data();
          DailyRevenue dailyRevenue = DailyRevenue.fromJson(data);
          list.add(dailyRevenue);
        }
        return list;
      } else {
        print("Data is null");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // post method
  Future<void> startADay(String shopID) async {
    try {
      DailyRevenue dailyRevenue =
          DailyRevenue(date: DateTime.now(), revenue: 0, shopID: shopID);
      await _firestore
          .collection('dailyRevenues')
          .doc(dailyRevenue.id)
          .set(dailyRevenue.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // update daily revenue
  Future<void> updateDailyRevenue(
      String shopID, DateTime date, int revenue) async {
    try {
      final doc = _firestore
          .collection('dailyRevenues')
          .where('shopID', isEqualTo: shopID)
          .where('date', isEqualTo: date)
          .limit(1);
      final ref = await doc.get();
      if (ref.docs.isNotEmpty) {
        final data = ref.docs[0].data();
        DailyRevenue dailyRevenue = DailyRevenue.fromJson(data);
        dailyRevenue.revenue = dailyRevenue.revenue! + revenue;
        await _firestore
            .collection('dailyRevenues')
            .doc(dailyRevenue.id)
            .update(dailyRevenue.toJson());
      } else {
        print("Data is null");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // admin sides
// category sections
  Future<void> addCategory(Category category) async {
    try {
      await _firestore
          .collection('categories')
          .doc(category.id)
          .set(category.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> editCategory(
      {required String id, String? logo, String? name}) async {
    try {
      final cateDoc = _firestore.collection('categories').doc(id);
      final ref = await cateDoc.get();
      if (ref.exists) {
        final data = ref.data();
        Category category = Category.fromJson(data!);
        category.logo = logo ?? category.logo;
        category.name = name ?? category.name;
        await cateDoc.update(category.toJson());
      } else {
        print("Not exist");
      }
    } catch (e) {
      print("An error occured: $e");
    }
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

  Future<Category?> getCategoryByID(String id) async {
    try {
      final ref = await _firestore.collection('categories').doc(id).get();
      if (ref.exists) {
        final data = ref.data();
        return Category.fromJson(data!);
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // flash sales section
  Future<void> addFlashSale(FlashSale flashSale) async {
    try {
      await _firestore
          .collection('flashSales')
          .doc(flashSale.id)
          .set(flashSale.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<FlashSale>?> getListFlashSale() async {
    try {
      final ref = await _firestore.collection('flashSales').get();
      if (ref.docs.isNotEmpty) {
        List<FlashSale>? list = [];
        for (var flashSaleData in ref.docs) {
          final data = flashSaleData.data();
          FlashSale flashSale = FlashSale.fromJson(data);
          // FlashSale(
          //   coverImage: data['coverImage'],
          //   discountPercent: data['discountPercent'],
          //   expDate: data['expDate'],
          //   id: data['id'],
          //   name: data['name'],
          //   releasedDate: data['releasedDate'],
          // );
          list.add(flashSale);
        }
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<FlashSale>?> getListActiveFlashSale() async {
    try {
      final ref = await _firestore
          .collection('flashSales')
          .where('expDate', isLessThan: Timestamp.now())
          .where('isDeleted', isEqualTo: false)
          .get();
      if (ref.docs.isNotEmpty) {
        List<FlashSale>? list = [];
        for (var flashSaleData in ref.docs) {
          final data = flashSaleData.data();
          FlashSale flashSale = FlashSale.fromJson(data);
          // FlashSale flashSale = FlashSale(
          //   coverImage: data['coverImage'],
          //   discountPercent: data['discountPercent'],
          //   expDate: data['expDate'],
          //   id: data['id'],
          //   name: data['name'],
          //   releasedDate: data['releasedDate'],
          // );
          list.add(flashSale);
        }
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Stream<List<FlashSale>?> getAllFlashSale() async* {
    try {
      final ref = await _firestore.collection('flashSales').snapshots();
      StreamController<List<FlashSale>?> streamController =
          StreamController<List<FlashSale>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<FlashSale>? list = [];
        if (event.docs.isNotEmpty) {
          // streamController.sink.add(true);

          for (var flashSaleData in event.docs) {
            final data = flashSaleData.data();
            // FlashSale flashSale = FlashSale(
            //   coverImage: data['coverImage'],
            //   discountPercent: data['discountPercent'],
            //   expDate: data['expDate'],
            //   id: data['id'],
            //   name: data['name'],
            //   releasedDate: data['releasedDate'],
            // );
            FlashSale flashSale = FlashSale.fromJson(data);
            list.add(flashSale);
          }
        } else {
          // streamController.sink.add(false);
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

  Stream<List<FlashSale>?> getAllActiveFlashSale() async* {
    try {
      final ref = await _firestore
          .collection('flashSales')
          .where('expDate', isLessThan: Timestamp.now())
          .where('isDeleted', isEqualTo: false)
          .snapshots();
      StreamController<List<FlashSale>?> streamController =
          StreamController<List<FlashSale>?>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        List<FlashSale>? list = [];
        if (event.docs.isNotEmpty) {
          // streamController.sink.add(true);

          for (var flashSaleData in event.docs) {
            final data = flashSaleData.data();
            // FlashSale flashSale = FlashSale(
            //   coverImage: data['coverImage'],
            //   discountPercent: data['discountPercent'],
            //   expDate: data['expDate'],
            //   id: data['id'],
            //   name: data['name'],
            //   releasedDate: data['releasedDate'],
            // );
            FlashSale flashSale = FlashSale.fromJson(data);
            list.add(flashSale);
          }
        } else {
          // streamController.sink.add(false);
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

  // add seller by admin
  Future<void> addSellerByAdmin(UserModel userModel, Shop shop) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
      await _firestore.collection('shops').doc(shop.id).set(shop.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<VerificationForm?> getVerificationFormByID(String id) async {
    try {
      final ref =
          await _firestore.collection('verificationForms').doc(id).get();
      if (ref.exists) {
        final data = ref.data();
        VerificationForm verificationForm = VerificationForm.fromJson(data!);
        return verificationForm;
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<UserModel>?> getListUnVerifiedSeller() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isNotEmpty) {
        List<UserModel> list = [];
        for (var element in ref.docs) {
          final data = element.data();
          UserModel user = UserModel.fromJson(data);
          if (user.userInfor!.sellerInfor != null) {
            if (!user.userInfor!.sellerInfor!.isVerified!) {
              bool? isExist = await isVerificatioinFormExist(
                  user.userInfor!.sellerInfor!.shopIDs![0]);
              if (isExist != null) {
                if (isExist) {
                  list.add(user);
                }
              }
            }
          }
        }
        return list;
      } else {
        print("EMPTY");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<bool?> isVerificatioinFormExist(String id) async {
    try {
      final ref =
          await _firestore.collection('verificationForms').doc(id).get();
      return ref.exists;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<UserModel>?> getListVerifiedSeller() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isNotEmpty) {
        List<UserModel> list = [];
        for (var element in ref.docs) {
          final data = element.data();
          UserModel user = UserModel.fromJson(data);
          if (user.userInfor!.sellerInfor != null) {
            if (user.userInfor!.sellerInfor!.isVerified!) {
              bool? isExist = await isVerificatioinFormExist(
                  user.userInfor!.sellerInfor!.shopIDs![0]);
              if (isExist != null) {
                if (isExist) {
                  list.add(user);
                }
              }
            }
          }
        }
        return list;
      } else {
        print("EMPTY");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<VerificationForm>?> getListVerificationForm() async {
    try {
      final ref = await _firestore.collection('verrificationForms').get();
      if (ref.docs.isNotEmpty) {
        List<VerificationForm> list = [];
        for (var element in ref.docs) {
          final data = element.data();
          VerificationForm verificationForm = VerificationForm.fromJson(data);
          list.add(verificationForm);
        }
        return list;
      } else {
        print("EMpty");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> confirmSellerRequest(VerificationForm verificationForm) async {
    try {
      final userDoc =
          _firestore.collection('users').doc(verificationForm.sellerID);
      final ref = await userDoc.get();
      if (ref.exists) {
        final data = ref.data();
        UserModel user = UserModel.fromJson(data!);
        user.userInfor!.sellerInfor!.isVerified = true;
        await userDoc.update(user.toJson());
      } else {
        print("NOT exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalUser() async {
    try {
      final ref = await _firestore.collection('users').get();
      return ref.size;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalConsumer() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isEmpty) {
        return 0;
      } else {
        int result = 0;
        for (var element in ref.docs) {
          final data = element.data();
          UserInfor? userInfor = data['userInfor'] != null
              ? UserInfor.fromJson(data['userInfor'])
              : null;
          if (userInfor != null) {
            var role = Role.values.firstWhere(
              (element) => element.toString().split(".").last == data['role'],
              orElse: () => Role.admin,
            );
            if (role == Role.consumer || role == Role.mixedUser) {
              result++;
            }
          } else {
            return 0;
          }
        }
        return result;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalSeller() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isEmpty) {
        return 0;
      } else {
        int result = 0;
        for (var element in ref.docs) {
          final data = element.data();
          UserInfor? userInfor = data['userInfor'] != null
              ? UserInfor.fromJson(data['userInfor'])
              : null;
          if (userInfor != null) {
            var role = Role.values.firstWhere(
              (element) => element.toString().split(".").last == data['role'],
              orElse: () => Role.admin,
            );
            if (role == Role.seller || role == Role.mixedUser) {
              result++;
            }
          } else {
            return 0;
          }
        }
        return result;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalConsumerNotUser() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isEmpty) {
        return 0;
      } else {
        int result = 0;
        for (var element in ref.docs) {
          final data = element.data();
          UserInfor? userInfor = data['userInfor'] != null
              ? UserInfor.fromJson(data['userInfor'])
              : null;
          if (userInfor != null) {
            var role = Role.values.firstWhere(
              (element) => element.toString().split(".").last == data['role'],
              orElse: () => Role.admin,
            );
            if (role == Role.seller) {
              result++;
            }
          } else {
            return 0;
          }
        }
        return result;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalUserNotBeSeller() async {
    try {
      final ref = await _firestore.collection('users').get();
      if (ref.docs.isEmpty) {
        return 0;
      } else {
        int result = 0;
        for (var element in ref.docs) {
          final data = element.data();
          UserInfor? userInfor = data['userInfor'] != null
              ? UserInfor.fromJson(data['userInfor'])
              : null;
          if (userInfor != null) {
            var role = Role.values.firstWhere(
              (element) => element.toString().split(".").last == data['role'],
              orElse: () => Role.admin,
            );
            if (role == Role.consumer) {
              result++;
            }
          } else {
            return 0;
          }
        }
        return result;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // delivery service section
  Future<void> addDeliverService(DeliverService deliverService) async {
    try {
      await _firestore
          .collection('deliverservices')
          .doc(deliverService.id)
          .set(deliverService.toJson());
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<DeliverService?> getDeliveryService(String id) async {
    try {
      final docs = await _firestore.collection('deliverservices').doc(id).get();
      if (docs.exists) {
        final data = docs.data();
        return DeliverService(
            id: data!['id'], logo: data!['logo'], name: data['name']);
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<DeliverService>?> getDeliverServiceList() async {
    try {
      List<DeliverService> list = [];
      final snapshot = await _firestore
          .collection('deliverservices')
          .where('isDeleted', isEqualTo: false)
          .get();
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

  Future<void> deleteDeliveryService(String id) async {
    try {
      // await _firestore.collection('deliverservices').doc(id).delete();
      final docs = _firestore.collection('deliverservices').doc(id);
      final ref = await docs.get();
      if (ref.exists) {
        DeliverService deliverService = DeliverService.fromJson(ref.data()!);
        deliverService.isDeleted = true;
        await docs.update(deliverService.toJson());
      } else {
        print("NOT exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> editDeliveryService(
      {required String id, String? name, String? logo}) async {
    try {
      final deliverServiceDoc =
          _firestore.collection('deliverservices').doc(id);
      final ref = await deliverServiceDoc.get();
      if (ref.exists) {
        final data = ref.data();
        DeliverService deliverService = DeliverService.fromJson(data!);
        deliverService.logo = logo ?? deliverService.logo;
        deliverService.name = name ?? deliverService.name;
        await deliverServiceDoc.update(deliverService.toJson());
      } else {
        print("Not exist");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // payment sections
  Future<PaymentType?> getPaymentByID(String id) async {
    try {
      final ref = await _firestore.collection('payments').doc(id).get();
      if (ref.exists) {
        PaymentType paymentType = PaymentType.fromJson(ref.data()!);
        return paymentType;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<PaymentType>?> getListPayment() async {
    try {
      final ref = await _firestore
          .collection('payments')
          .where('isDeleted', isEqualTo: false)
          .get();

      if (ref.docs.isNotEmpty) {
        List<PaymentType>? list = [];
        for (var data in ref.docs) {
          PaymentType paymentType = PaymentType.fromJson(data.data());
          list.add(paymentType);
        }
        return list;
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<void> deletePaymentByID(String id) async {
    try {
      // final ref = await _firestore.collection('payments').doc(id).delete();
      final docs = _firestore.collection('payments').doc(id);
      final ref = await docs.get();
      if (ref.exists) {
        PaymentType paymentType = PaymentType.fromJson(ref.data()!);
        paymentType.isDeleted = true;
        await docs.update(paymentType.toJson());
      } else {
        print("NOT exists");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  // report by admin
  Future<int?> getTotalOrder() async {
    try {
      final ref = await _firestore.collection('orders').get();
      return ref.size;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalProduct() async {
    try {
      final ref = await _firestore.collection('products').get();
      return ref.size;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalDeliveryService() async {
    try {
      final ref = await _firestore.collection('deliverservices').get();
      return ref.size;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<int?> getTotalCategory() async {
    try {
      final ref = await _firestore.collection('categories').get();
      return ref.size;
    } catch (e) {
      print("An error occured: $e");
    }
  }

  Future<List<CategoryChart>?> getTotalProductOfEachCategory() async {
    try {
      List<Category>? listCategory = await getListCategory();
      List<Product>? listProduct = await getActiveProducts();
      if (listCategory != null && listCategory!.isNotEmpty) {
        if (listProduct != null && listProduct.isNotEmpty) {
          List<CategoryChart> list = [];
          for (var category in listCategory) {
            int total = 0;
            for (var product in listProduct) {
              if (product.categoryID == category.id) {
                total++;
              }
            }
            CategoryChart categoryChart = CategoryChart(category.name!, total);
            list.add(categoryChart);
          }
          return list;
        }
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }
}
