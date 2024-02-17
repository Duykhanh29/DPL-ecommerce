import 'package:dpl_ecommerce/models/address_response/ward_response.dart';

class District {
  String id;
  String name;
  List<Ward> wards;
  District({required this.id, required this.name, required this.wards});
  factory District.fromJson(Map<String, dynamic> json) {
    return District(
        id: json['Id'],
        name: json['Name'],
        wards: (json['Wards'] as List<dynamic>)
            .map((e) => Ward.fromJson(e))
            .toList());
  }
}
