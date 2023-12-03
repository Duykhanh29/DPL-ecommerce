import 'package:dpl_ecommerce/models/address_infor.dart';

enum Raking { bronze, silver, gold }

class ConsumerInfor {
  Raking? raking;
  int rewardPoints;
  List<AddressInfor>? addressInfors;
  ConsumerInfor(
      {this.addressInfors, this.raking = Raking.bronze, this.rewardPoints = 0});
  factory ConsumerInfor.fromJson(Map<String, dynamic> json) {
    return ConsumerInfor(
        raking: Raking.values.firstWhere(
          (element) => element.toString().split(".").last == json['raking'],
          orElse: () => Raking.gold,
        ),
        rewardPoints: json['rewardPoints'],
        addressInfors: (json['addressInfors'] as List<dynamic>)
            .map((e) => AddressInfor.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() => {
        "raking": raking!.toString().split(".").last,
        "addressInfors": addressInfors!.map((e) => e.toJson()).toList(),
        "rewardPoints": rewardPoints,
      };
}
