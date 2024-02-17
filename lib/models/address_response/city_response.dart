import 'package:dpl_ecommerce/models/address_response/district_response.dart';

class City {
  String id;
  String name;
  List<District> districts;
  City({required this.id, required this.name, required this.districts});
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
        id: json['Id'],
        name: json['Name'],
        districts: (json['Districts'] as List<dynamic>)
            .map((e) => District.fromJson(e))
            .toList());
  }
}
