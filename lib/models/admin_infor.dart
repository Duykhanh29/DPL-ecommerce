class AdminInfor {
  DateTime? adminCreatedAt;
  AdminInfor({this.adminCreatedAt});
  factory AdminInfor.fromJson(Map<String, dynamic> json) {
    return AdminInfor(
      adminCreatedAt: json['adminCreatedAt'],
    );
  }
  Map<String, dynamic> toJson() => {
        'adminCreatedAt': adminCreatedAt,
      };
}
