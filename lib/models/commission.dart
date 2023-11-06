class Commission {
  double percent;
  Commission({this.percent = 0.15});
  factory Commission.fromJson(Map<String, dynamic> json) {
    return Commission(percent: json['percent']);
  }
  Map<String, dynamic> toJson() => {'percent': percent};
}
