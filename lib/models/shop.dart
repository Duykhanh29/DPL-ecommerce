import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:uuid/uuid.dart';

class Shop {
  String? id;
  String? name;
  String? logo;
  double? rating;
  AddressInfor? addressInfor;
  String? contactPhone;
  int shopView;
  String? shopDescription;
  int totalProduct;
  int ratingCount;
  Shop(
      {this.addressInfor,
      this.contactPhone,
      this.id,
      this.logo,
      this.name,
      this.rating,
      this.shopView = 0,
      this.shopDescription,
      this.ratingCount = 0,
      this.totalProduct = 0}) {
    id ??= Uuid().v4();
  }
  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
        addressInfor: AddressInfor.fromJson(json['addressInfor']),
        contactPhone: json['contactPhone'],
        logo: json['logo'],
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        shopView: json['shopView'],
        shopDescription: json['shopDescription'],
        ratingCount: json['ratingCount'],
        totalProduct: json['totalProduct']);
  }
  Map<String, dynamic> toJson() => {
        'addressInfor': addressInfor!.toJson(),
        'contactPhone': contactPhone,
        'logo': logo,
        'id': id,
        'name': name,
        'rating': rating,
        'shopView': shopView,
        'shopDescription': shopDescription,
        'totalProduct': totalProduct,
        'ratingCount': ratingCount
      };
}
