class Language {
  String? id;
  String? name;
  String? image;
  bool? is_default;
  Language({
    this.id,
    this.name,
    this.image,
    this.is_default,
  });
  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        is_default: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "is_default": is_default,
      };
}
