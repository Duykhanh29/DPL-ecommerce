import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String? name;
  String? shopID;
  String? shopName;
  String? shopLogo;
  List<String>? images;
  List<String>? videos;
  String? voucherID;
  String? description;
  double? rating;
  Timestamp? updatedAt;
  Timestamp? createdAt;
  List<String>? sizes;
  int purchasingCount;
  int ratingCount;
  int? price;
  int? availableQuantity;
  String? categoryID;
  List<String>? types;
  List<String>? colors;
  List<String>? reviewIDs;
  // bool isDeleted;
  // bool isPulished;
  Product({
    this.availableQuantity,
    this.categoryID,
    this.colors,
    this.createdAt,
    this.description,
    this.id,
    this.images,
    this.name,
    this.price,
    this.purchasingCount = 0,
    this.rating,
    this.ratingCount = 0,
    this.reviewIDs,
    this.shopID,
    this.shopLogo,
    this.shopName,
    this.sizes,
    this.types,
    this.updatedAt,
    this.videos,
    this.voucherID,
    // this.isDeleted = false,
    // this.isPulished = false
  }) {
    id ??= Uuid().v4();
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      availableQuantity: json['availableQuantity'],
      categoryID: json['categoryID'],
      colors: json['colors'] != null
          ? (json['colors'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      id: json['id'],
      createdAt: (json['createdAt'] as Timestamp?),
      description: json['description'],
      images: json['images'] != null
          ? (json['images'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      name: json['name'],
      price: json['price'],
      purchasingCount: json['purchasingCount'],
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      shopID: json['shopID'],
      reviewIDs: json['reviewIDs'] != null
          ? (json['reviewIDs'] as List<dynamic>)
              .map((e) => e.toString())
              .toList()
          : null,
      shopLogo: json['shopLogo'],
      shopName: json['shopName'],
      updatedAt: (json['updatedAt'] as Timestamp?),
      voucherID: json['voucherID'],
      videos: json['videos'] != null
          ? (json['videos'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      sizes: json['sizes'] != null
          ? (json['sizes'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      types: json['types'] != null
          ? (json['types'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      // isDeleted: json['isDeleted'],
      // isPulished: json['isPulished'],
    );
  }
  Map<String, dynamic> toJson() => {
        'availableQuantity': availableQuantity,
        'categoryID': categoryID,
        'colors':
            colors != null ? colors!.map((e) => e.toString()).toList() : null,
        'id': id,
        'createdAt': createdAt,
        'description': description,
        'images':
            images != null ? images!.map((e) => e.toString()).toList() : null,
        'name': name,
        'price': price,
        'purchasingCount': purchasingCount,
        'rating': rating,
        'ratingCount': ratingCount,
        'shopID': shopID,
        'reviewIDs': reviewIDs != null
            ? reviewIDs!.map((e) => e.toString()).toList()
            : null,
        'shopLogo': shopLogo,
        'shopName': shopName,
        'updatedAt': updatedAt,
        'voucherID': voucherID,
        'videos':
            videos != null ? videos!.map((e) => e.toString()).toList() : null,
        'types':
            types != null ? types!.map((e) => e.toString()).toList() : null,
        'sizes':
            sizes != null ? sizes!.map((e) => e.toString()).toList() : null,
        // 'isDeleted': isDeleted,
        // 'isPulished': isPulished,
      };
}
