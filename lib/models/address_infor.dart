class AddressInfor {
  String? country;
  String? district;
  String? city;
  double? latitude;
  double? longitude;
  bool isDefaultAddress;
  String? name;
  AddressInfor(
      {this.city,
      this.country,
      this.isDefaultAddress = false,
      this.latitude,
      this.longitude,
      this.name,
      this.district});
  factory AddressInfor.fromJson(Map<String, dynamic> json) {
    return AddressInfor(
        country: json['country'],
        district: json['district'],
        city: json['city'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isDefaultAddress: json['isDefaultAddress'],
        name: json['name']);
  }
  Map<String, dynamic> toJson() => {
        'country': country,
        'district': district,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'isDefaultAddress': isDefaultAddress,
        'name': name
      };
}
