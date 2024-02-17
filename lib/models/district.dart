class District {
  District({
    this.id,
    this.name,
  });

  @override
  toString() => '$name';

  String? id;
  String? name;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["code"].toString(),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": id,
        "name": name,
      };
}
