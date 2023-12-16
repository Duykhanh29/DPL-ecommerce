class DailyRevenue {
  String? shopID;
  int? revenue;
  DateTime? date;
  DailyRevenue({this.shopID, this.revenue = 0, this.date});
  factory DailyRevenue.fromJson(Map<String, dynamic> json) {
    return DailyRevenue(
      shopID: json['shopID'],
      revenue: json['revenue'],
      date: json['date'],
    );
  }
  Map<String, dynamic> toJson() => {
        'shopID': shopID,
        'revenue': revenue,
        'date': date,
      };
}
