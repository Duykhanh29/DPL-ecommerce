class VoucherForUser {
  List<String>? vouchers;
  String? userID;
  VoucherForUser({this.userID, this.vouchers});
  factory VoucherForUser.fromJson(Map<String, dynamic> json) {
    return VoucherForUser(
        vouchers: (json['vouchers'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        userID: json['userID']);
  }
  Map<String, dynamic> toJson() => {
        'vouchers': vouchers!.map((e) => e.toString()).toList(),
        'userID': userID
      };
}
