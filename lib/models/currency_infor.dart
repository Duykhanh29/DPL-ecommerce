class CurrencyInfor {
  String? id;
  String? name;
  String? code;
  String? symbol;
  bool isDefault;
  CurrencyInfor(
      {this.code, this.id, this.isDefault = false, this.name, this.symbol});
  factory CurrencyInfor.fromJson(Map<String, dynamic> json) {
    return CurrencyInfor(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      code: json['code'],
      isDefault: json['isDefault'],
    );
  }
  Map<String, dynamic> toJson() => {
        'code': code,
        'id': id,
        'name': name,
        'isDefault': isDefault,
        'symbol': symbol,
      };
}
