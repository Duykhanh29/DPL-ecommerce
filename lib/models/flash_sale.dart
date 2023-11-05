import 'package:uuid/uuid.dart';

class FlashSale {
  String? id;
  DateTime? releasedDate;
  DateTime? expDate;
  int? discountPercent;
  FlashSale({this.id, this.discountPercent, this.expDate, this.releasedDate}) {
    id ??= Uuid().v4();
  }
  factory FlashSale.fromJson(Map<String, dynamic> json) {
    return FlashSale(
      releasedDate: json['releasedDate'],
      id: json['id'],
      expDate: json['expDate'],
      discountPercent: json['discountPercent'],
    );
  }
  Map<String, dynamic> toJson() => {
        'discountPercent': discountPercent,
        'id': id,
        'releasedDate': releasedDate,
        'expDate': expDate
      };
}
