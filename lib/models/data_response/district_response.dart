// To parse this JSON data, do
//
//     final MyStateResponse = myStateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dpl_ecommerce/models/district.dart';

DistrictResponse myStateResponseFromJson(String str) =>
    DistrictResponse.fromJson(json.decode(str));

String myStateResponseToJson(DistrictResponse data) =>
    json.encode(data.toJson());

class DistrictResponse {
  DistrictResponse({
    this.states,
    this.success,
    this.status,
  });

  List<District>? states;
  bool? success;
  int? status;

  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      DistrictResponse(
        states:
            List<District>.from(json["data"].map((x) => District.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(states!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}
