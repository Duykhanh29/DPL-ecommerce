import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Voucher {
  String? id;
  String? productID;
  String? shopID;
  int? discountPercent;
  int? discountAmount;
  Timestamp? releasedDate;
  Timestamp? expDate;
  String? name;
  bool isAdmin;
  Voucher(
      {this.discountAmount,
      this.discountPercent,
      this.expDate,
      this.id,
      this.productID,
      this.releasedDate,
      this.shopID,
      this.name,
      this.isAdmin = false}) {
    this.id ??= Uuid().v4();
  }
  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
        discountAmount: json['discountAmount'],
        discountPercent: json['discountPercent'],
        expDate: (json['expDate'] as Timestamp?),
        id: json['id'],
        productID: json['productID'],
        releasedDate: (json['releasedDate'] as Timestamp?),
        shopID: json['shopID'],
        name: json['name'],
        isAdmin: json['isAdmin']);
  }
  Map<String, dynamic> toJson() => {
        'discountAmount': discountAmount,
        'discountPercent': discountPercent,
        'expDate': expDate,
        'id': id,
        'productID': productID,
        'releasedDate': releasedDate,
        'shopID': shopID,
        'name': name,
        'isAdmin': isAdmin
      };
}
