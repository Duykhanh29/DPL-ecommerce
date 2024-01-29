class PaymentType {
  String? id;
  String? name;
  String? symbol;
  bool isDeleted;
  PaymentType({this.id, this.name, this.symbol, this.isDeleted = false});
  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(
        name: json['name'],
        id: json['id'],
        symbol: json['symbol'],
        isDeleted: json['isDeleted']);
  }
  Map<String, dynamic> toJson() =>
      {'name': name, 'id': id, 'symbol': symbol, 'isDeleted': isDeleted};
}
