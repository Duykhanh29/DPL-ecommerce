class City {
  City({
    this.id,
    this.name,
  });

  @override
  toString() => '$name';

  int? id;
  String? name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": id,
        "name": name,
      };
}
