// To parse this JSON data, do
//
//     final cityResponse = cityResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dpl_ecommerce/models/city.dart';

CityResponse cityResponseFromJson(String str) =>
    CityResponse.fromJson(json.decode(str));

String cityResponseToJson(CityResponse data) => json.encode(data.toJson());

class CityResponse {
  CityResponse({
    this.cities,
    this.success,
    this.status,
  });

  List<City>? cities;
  bool? success;
  int? status;

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        cities: List<City>.from(json["data"].map((x) => City.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(cities!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}
