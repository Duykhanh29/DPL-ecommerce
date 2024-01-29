import 'package:uuid/uuid.dart';

class Category {
  String? id;
  String? name;
  String? logo;
  // bool isDeleted;
  Category({
    this.id,
    this.name,
    this.logo,
    // this.isDeleted = false,
  }) {
    id ??= Uuid().v4();
  }
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      // isDeleted: json['isDeleted']
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id, 'name': name, 'logo': logo,
        // 'isDeleted': isDeleted,
      };
}
