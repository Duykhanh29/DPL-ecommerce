class AddressInfor {
  String? country;
  String? district;
  String? city;
  double? latitude;
  double? longitude;
  bool isDefaultAddress;
  String? name;
  String? number;
  String? ward;
  String? id;
  AddressInfor(
      {this.city,
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
        country: json['country'],
        district: json['district'],
        city: json['city'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isDefaultAddress: json['isDefaultAddress'],
        name: json['name'],
        number: json['number'],
        ward: json['ward'],
        id: json['id'],
        
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
