class AddressInfor {
  String? country;
  String? state;
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
      this.state});
  factory AddressInfor.fromJson(Map<String, dynamic> json) {
    return AddressInfor(
        country: json['country'],
        state: json['state'],
        city: json['city'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isDefaultAddress: json['isDefaultAddress'],
        name: json['name']);
  }
  Map<String, dynamic> toJson() => {
        'country': country,
        'state': state,
        'city': city,
        'latitude': latitude,
        'longitude': longitude,
        'isDefaultAddress': isDefaultAddress,
        'name': name
      };
}
