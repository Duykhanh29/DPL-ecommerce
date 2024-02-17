class Ward {
  String? id;
  String? name;
  String? level;
  Ward({ this.id,  this.level,  this.name});
  factory Ward.fromJson(Map<String, dynamic> json) {
    return Ward(id: json['Id'], level: json['Level'], name: json['Name']);
  }
  // Map<String,dynamic> toJson()=>{

  // }
}
