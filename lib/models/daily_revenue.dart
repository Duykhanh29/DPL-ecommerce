import 'package:uuid/uuid.dart';

class DailyRevenue {
  String? id;
  String? shopID;
  int? revenue;
  DateTime? date;
  DailyRevenue({this.shopID, this.revenue = 0, this.date, this.id}) {
    id ??= Uuid().v4();
  }
  factory DailyRevenue.fromJson(Map<String, dynamic> json) {
    return DailyRevenue(
        shopID: json['shopID'],
        revenue: json['revenue'],
        date: json['date'],
        id: json['id']);
  }
  Map<String, dynamic> toJson() => {
        'shopID': shopID,
        'revenue': revenue,
        'date': date,
        'id': id,
      };
}
