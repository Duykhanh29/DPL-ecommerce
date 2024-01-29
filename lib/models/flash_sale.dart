import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlashSale {
  String? id;
  Timestamp? releasedDate;
  Timestamp? expDate;
  int? discountPercent;
  String? coverImage;
  String? name;
  bool isDeleted;
  FlashSale(
      {this.id,
      this.discountPercent,
      this.expDate,
      this.releasedDate,
      this.coverImage,
      this.name,
      this.isDeleted = false}) {
    id ??= Uuid().v4();
  }
  factory FlashSale.fromJson(Map<String, dynamic> json) {
    return FlashSale(
        releasedDate: json['releasedDate'],
        id: json['id'],
        expDate: json['expDate'],
        discountPercent: json['discountPercent'],
        coverImage: json['coverImage'],
        name: json['name'],
        isDeleted: json['isDeleted']);
  }
  Map<String, dynamic> toJson() => {
        'discountPercent': discountPercent,
        'id': id,
        'releasedDate': releasedDate,
        'expDate': expDate,
        'coverImage': coverImage,
        'name': name,
        'isDeleted': isDeleted
      };
}
