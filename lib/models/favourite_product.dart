class FavouriteProduct {
  String? id;
  String? userID;
  String? productID;
  DateTime? createdAt;
  FavouriteProduct({this.createdAt, this.id, this.productID, this.userID});
  factory FavouriteProduct.fromJson(Map<String, dynamic> json) {
    return FavouriteProduct(
      userID: json['userID'],
      id: json['id'],
      productID: json['productID'],
      createdAt: json['createdAt'],
    );
  }
  Map<String, dynamic> toJson() => {
        'userID': userID,
        'id': id,
        'productID': productID,
        'createdAt': createdAt
      };
}