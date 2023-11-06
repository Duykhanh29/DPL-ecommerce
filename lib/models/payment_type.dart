class PaymentType {
  String? id;
  String? name;
  String? symbol;
  PaymentType({this.id, this.name, this.symbol});
  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(
        name: json['name'], id: json['id'], symbol: json['symbol']);
  }
  Map<String, dynamic> toJson() => {'name': name, 'id': id, 'symbol': symbol};
}
