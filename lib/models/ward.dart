class Ward {
  Ward({
    this.id,
    this.name,
  });

  @override
  toString() => '$name';

  int? id;
  String? name;

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": id,
        "name": name,
      };
}
