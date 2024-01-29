import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:uuid/uuid.dart';

class AddressInfor {
  String? id;
  String? country;
  District? district;
  City? city;
  double? latitude;
  double? longitude;
  bool isDefaultAddress;
  String? name;
  String? number;
  Ward? ward;
  bool isDeleted;
  AddressInfor({
    this.city,
    this.country,
    this.isDefaultAddress = false,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.name,
    this.number,
    this.ward,
    this.district,
    this.id,
    this.isDeleted = false,
  }) {
    id ??= Uuid().v4();
  }
  factory AddressInfor.fromJson(Map<String, dynamic> json) {
    return AddressInfor(
        id: json['id'],
        country: json['country'],
        district: District.fromJson(json['district']),
        city: City.fromJson(json['city']),
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        isDefaultAddress: json['isDefaultAddress'],
        name: json['name'],
        number: json['number'],
        ward: Ward.fromJson(json['ward']),
        isDeleted: json['isDeleted']);
  }
  Map<String, dynamic> toJson() => {
        'country': country,
        'district': district!.toJson(),
        'city': city!.toJson(),
        'latitude': latitude,
        'longitude': longitude,
        'isDefaultAddress': isDefaultAddress,
        'name': name,
        'number': number,
        'ward': ward!.toJson(),
        'id': id,
        'isDeleted': isDeleted
      };
}
