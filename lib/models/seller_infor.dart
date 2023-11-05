class SellerInfor {
  List<String>? shopIDs;
  bool? isVerified;
  SellerInfor({this.isVerified, this.shopIDs});
  factory SellerInfor.fromJson(Map<String, dynamic> json) {
    return SellerInfor(
        isVerified: json['isVerified'], shopIDs: json['shopIDs']);
  }
  Map<String, dynamic> toJson() => {
        "isVerified": isVerified,
        "shopIDs": shopIDs,
      };
}
