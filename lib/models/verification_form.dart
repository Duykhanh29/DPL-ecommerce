import 'package:dpl_ecommerce/models/address_infor.dart';

class VerificationForm {
  String? shopID;
  String? sellerID;
  String? taxPaper;
  String? licenseNo;
  AddressInfor? contactAddress;
  String? shopName;
  String? phoneNumber;
  String? homeNumber;
  String? email;

  VerificationForm(
      {this.shopID,
      this.sellerID,
      this.taxPaper,
      this.licenseNo,
      this.contactAddress,
      this.shopName,
      this.phoneNumber,
      this.homeNumber,
      this.email});
  factory VerificationForm.fromJson(Map<String, dynamic> json) {
    return VerificationForm(
      shopID: json['shopID'],
      sellerID: json['sellerID'],
      taxPaper: (json['taxPaper']),
      licenseNo: json['licenseNo'],
      contactAddress: AddressInfor.fromJson(json['contactAddress']),
      shopName: (json['shopName']),
      phoneNumber: json['phoneNumber'],
      homeNumber: (json['homeNumber']),
      email: json['email'],
    );
  }
  Map<String, dynamic> toJson() => {
        'shopID': shopID,
        'sellerID': sellerID,
        'taxPaper': taxPaper,
        'licenseNo': licenseNo,
        'contactAddress': contactAddress!.toJson(),
        'shopName': shopName,
        'phoneNumber': phoneNumber,
        'homeNumber': homeNumber,
        'email': email
      };
}
