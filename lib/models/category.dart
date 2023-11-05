import 'package:uuid/uuid.dart';

class Category {
  String? id;
  String? name;
  Category({this.id, this.name}) {
    id ??= Uuid().v4();
  }
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
