import 'package:uuid/uuid.dart';

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
  DateTime? updatedAt;
  DateTime? createdAt;
  List<String>? sizes;
  int purchasingCount;
  int ratingCount;
  int? price;
  int? availableQuantity;
  String? categoryID;
  List<String>? types;
  List<String>? colors;
  List<String>? reviewIDs;
  Product(
      {this.availableQuantity,
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
      this.voucherID}) {
    id ??= Uuid().v4();
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      availableQuantity: json['availableQuantity'],
      categoryID: json['categoryID'],
      colors:
          (json['colors'] as List<dynamic>).map((e) => e.toString()).toList(),
      id: json['id'],
      createdAt: json['createdAt'],
      description: json['description'],
      images:
          (json['images'] as List<dynamic>).map((e) => e.toString()).toList(),
      name: json['name'],
      price: json['price'],
      purchasingCount: json['purchasingCount'],
      rating: json['rating'],
      ratingCount: json['ratingCount'],
      shopID: json['shopID'],
      reviewIDs: (json['reviewIDs'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      shopLogo: json['shopLogo'],
      shopName: json['shopName'],
      updatedAt: json['updatedAt'],
      voucherID: json['voucherID'],
      videos:
          (json['videos'] as List<dynamic>).map((e) => e.toString()).toList(),
      sizes: (json['sizes'] as List<dynamic>).map((e) => e.toString()).toList(),
      types: (json['types'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'availableQuantity': availableQuantity,
        'categoryID': categoryID,
        'colors': colors!.map((e) => e.toString()).toList(),
        'id': id,
        'createdAt': createdAt,
        'description': description,
        'images': images!.map((e) => e.toString()).toList(),
        'name': name,
        'price': price,
        'purchasingCount': purchasingCount,
        'rating': rating,
        'ratingCount': ratingCount,
        'shopID': shopID,
        'reviewIDs': reviewIDs!.map((e) => e.toString()).toList(),
        'shopLogo': shopLogo,
        'shopName': shopName,
        'updatedAt': updatedAt,
        'voucherID': voucherID,
        'videos': videos!.map((e) => e.toString()).toList(),
        'types': types!.map((e) => e.toString()).toList(),
        'sizes': sizes!.map((e) => e.toString()).toList(),
      };
}
