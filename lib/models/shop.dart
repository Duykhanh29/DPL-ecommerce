import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:uuid/uuid.dart';

class Shop {
  String? id;
  String? name;
  String? logo;
  double? rating;
  AddressInfor? addressInfor;
  String? contactPhone;
  Shop(
      {this.addressInfor,
      this.contactPhone,
      this.id,
      this.logo,
      this.name,
      this.rating}) {
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
    );
  }
  Map<String, dynamic> toJson() => {
        'addressInfor': addressInfor!.toJson(),
        'contactPhone': contactPhone,
        'logo': logo,
        'id': id,
        'name': name,
        'rating': rating,
      };
}
