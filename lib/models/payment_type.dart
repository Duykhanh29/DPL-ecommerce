class PaymentType {
  String? id;
  String? name;
  PaymentType({this.id, this.name});
  factory PaymentType.fromJson(Map<String, dynamic> json) {
    return PaymentType(
      name: json['name'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };
}
