class RecommendedProducts {
  String? userID;
  List<String>? categories;
  List<String>? shops;
  RecommendedProducts({this.categories, this.shops, this.userID});
  factory RecommendedProducts.fromJson(Map<String, dynamic> json) {
    return RecommendedProducts(
      shops: (json['shops'] as List<dynamic>).map((e) => e.toString()).toList(),
      userID: json['userID'],
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
  Map<String, dynamic> toJson() => {
        'categories': categories!.map((e) => e.toString()).toList(),
        'userID': userID,
        'shops': shops!.map((e) => e.toString()).toList(),
      };
}
