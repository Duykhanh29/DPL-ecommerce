class RecommendedProducts {
  int? id;
  String? userID;
  String? categoryID;
  String? shopID;
  RecommendedProducts({this.categoryID, this.shopID, this.userID, this.id});
  factory RecommendedProducts.fromJson(Map<String, dynamic> json) {
    return RecommendedProducts(
        shopID: (json['shopID']),
        userID: json['userID'],
        categoryID: (json['categoryID']),
        id: json['id']);
  }
  Map<String, dynamic> toJson() => {
        'categoryID': categoryID,
        'userID': userID,
        'shopID': shopID,
        'id': id,
      };
}
