import 'package:dpl_ecommerce/models/address_infor.dart';

class SellerInfor {
  List<String>? shopIDs;
  bool? isVerified;
  String? taxPaper;
  String? licenseNo;
  AddressInfor? contactAddress;
  SellerInfor(
      {this.isVerified,
      this.shopIDs,
      this.licenseNo,
      this.taxPaper,
      contactAddress});
  factory SellerInfor.fromJson(Map<String, dynamic> json) {
    return SellerInfor(
        isVerified: json['isVerified'],
        shopIDs: json['shopIDs'] != null
            ? (json['shopIDs'] as List<dynamic>)
                .map((e) => e.toString())
                .toList()
            : null,
        licenseNo: json['licenseNo'],
        contactAddress: AddressInfor.fromJson(
          json['contactAddress'],
        ),
        taxPaper: json['taxPaper']);
  }
  Map<String, dynamic> toJson() => {
        "isVerified": isVerified,
        "shopIDs": shopIDs!.map((e) => e.toString()).toList(),
        "licenseNo": licenseNo,
        'contactAddress': contactAddress!.toJson(),
        'taxPaper': taxPaper
      };
}
