// To parse this JSON data, do
//
//     final MyStateResponse = myStateResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dpl_ecommerce/models/ward.dart';

WardResponse myStateResponseFromJson(String str) =>
    WardResponse.fromJson(json.decode(str));

String myStateResponseToJson(WardResponse data) => json.encode(data.toJson());

class WardResponse {
  WardResponse({
    this.states,
    this.success,
    this.status,
  });

  List<Ward>? states;
  bool? success;
  int? status;

  factory WardResponse.fromJson(Map<String, dynamic> json) => WardResponse(
        states: List<Ward>.from(json["data"].map((x) => Ward.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(states!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}
