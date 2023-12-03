import 'package:uuid/uuid.dart';

class AddressInfor {
  String? id;
  String? country;
  String? district;
  String? city;
  double? latitude;
  double? longitude;
  bool isDefaultAddress;
  String? name;
  String? number;
  String? ward;
  AddressInfor({
    this.city,
    this.country,
    this.isDefaultAddress = false,
    this.latitude,
    this.longitude,
    this.name,
    this.number,
    this.ward,
    this.district,
    this.id,
  });
  factory AddressInfor.fromJson(Map<String, dynamic> json) {
    return AddressInfor(
      id: json['id'],
      country: json['country'],
      district: json['district'],
      city: json['city'],
      latitude: (json['latitude'] as double),
      longitude: (json['longitude'] as double),
      isDefaultAddress: json['isDefaultAddress'],
      name: json['name'],
      number: json['number'],
      ward: json['ward'],
    );
  }
  Map<String, dynamic> toJson() => {
        'country': country,
        'district': district,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'isDefaultAddress': isDefaultAddress,
        'name': name,
        'number': number,
        'ward': ward,
        'id': id,
      };
}
