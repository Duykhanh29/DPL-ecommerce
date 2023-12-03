import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/product.dart';

class ProductFirestoreDatabase {
  ProductFirestoreDatabase();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   // products
//   Future<void> postProduct(Product product) async {
//     await _firestore
//         .collection('products')
//         .doc(product.id)
//         .set(product.toJson());
//   }

//   Future<List<Product>?> getActiveProducts() async {
//     try {
//       List<Product> list = [];
//       final snapshot = await _firestore
//           .collection('products')
//           .where('availableQuantity', isGreaterThan: 0)
//           .get();
//       for (var data in snapshot.docs) {
//         final productData = data.data();
//         Product product = Product.fromJson(productData);
//         list.add(product);
//       }
//       return list;
//     } catch (e) {
//       print("An error occured: $e");
//     }
//   }

//   Stream<List<Product>?> getListActiveProduct() async* {
//     try {
//       final ref = _firestore
//           .collection('products')
//           .where('availableQuantity', isGreaterThan: 0)
//           .snapshots();
//       StreamController<List<Product>?> streamController =
//           StreamController<List<Product>?>();
//       StreamSubscription streamSubscription = ref.listen((event) {
//         List<Product>? list = [];
//         if (event.docs.isNotEmpty) {
//           for (var data in event.docs) {
//             // final dataHere = data.data();
//             //  Product p = Product.fromJson({'id': data.id, ...data.data()});
//             Product product = Product(
//               id: data.id,
//               availableQuantity: data.data()['availableQuantity'],
//               categoryID: data.data()['categoryID'],
//               description: data.data()['description'],
//               colors: data.data()['colors'] != null
//                   ? (data.data()['colors'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               createdAt: data.data()['createdAt'],
//               images: data.data()['images'] != null
//                   ? (data.data()['images'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               name: data.data()['name'],
//               price: data.data()['price'],
//               purchasingCount: data.data()['purchasingCount'],
//               rating: data.data()['rating'],
//               ratingCount: data.data()['ratingCount'],
//               reviewIDs: data.data()['reviewIDs'] != null
//                   ? (data.data()['reviewIDs'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               shopID: data.data()['shopID'],
//               shopLogo: data.data()['shopLogo'],
//               shopName: data.data()['shopName'],
//               sizes: data.data()['sizes'] != null
//                   ? (data.data()['sizes'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               types: data.data()['types'] != null
//                   ? (data.data()['types'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               updatedAt: data.data()['updatedAt'],
//               videos: data.data()['videos'] != null
//                   ? (data.data()['videos'] as List<dynamic>)
//                       .map((e) => e.toString())
//                       .toList()
//                   : null,
//               voucherID: data.data()['voucherID'],
//             );
//             list.add(product);
//           }
//           streamController.sink.add(list);
//         }
//       });
//       streamController.onCancel = () {
//         streamSubscription.cancel();
//         streamController.close();
//       };
//       yield* streamController.stream;
//     } catch (e) {
//       print("An error occured: $e");
//     }
//   }

//   Future<void> updateProduct({
//     required String productID,
//     int? quantity,
//     int? cost,
//     List<String>? colors,
//     List<String>? types,
//     List<String>? sizes,
//     List<String>? images,
//     List<String>? videos,
//     String? description,
//     int? ratingCount,
//     int? purchasingCount,
//   }) async {
// // update product
//   }
//   Future<void> buyAProduct() async {}

//   // get products list of a shop
//   Future<List<Product>?> getProductListByShop(String shopID) async {
//     try {
//       List<Product> list = [];
//       final snapshot = await _firestore
//           .collection('products')
//           .where('availableQuantity', isGreaterThan: 0)
//           .where('shopID', isEqualTo: shopID)
//           .get();
//       for (var data in snapshot.docs) {
//         Product product = Product(
//           id: data.id,
//           availableQuantity: data.data()['availableQuantity'],
//           categoryID: data.data()['categoryID'],
//           description: data.data()['description'],
//           colors: data.data()['colors'] != null
//               ? (data.data()['colors'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           createdAt: data.data()['createdAt'],
//           images: data.data()['images'] != null
//               ? (data.data()['images'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           name: data.data()['name'],
//           price: data.data()['price'],
//           purchasingCount: data.data()['purchasingCount'],
//           rating: data.data()['rating'],
//           ratingCount: data.data()['ratingCount'],
//           reviewIDs: data.data()['reviewIDs'] != null
//               ? (data.data()['reviewIDs'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           shopID: data.data()['shopID'],
//           shopLogo: data.data()['shopLogo'],
//           shopName: data.data()['shopName'],
//           sizes: data.data()['sizes'] != null
//               ? (data.data()['sizes'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           types: data.data()['types'] != null
//               ? (data.data()['types'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           updatedAt: data.data()['updatedAt'],
//           videos: data.data()['videos'] != null
//               ? (data.data()['videos'] as List<dynamic>)
//                   .map((e) => e.toString())
//                   .toList()
//               : null,
//           voucherID: data.data()['voucherID'],
//         );
//         list.add(product);
//       }
//       return list;
//     } catch (e) {
//       print("An error occured: $e");
//     }
//   }
}
