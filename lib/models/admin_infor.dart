import 'package:cloud_firestore/cloud_firestore.dart';

class AdminInfor {
  Timestamp? adminCreatedAt;
  AdminInfor({this.adminCreatedAt});
  factory AdminInfor.fromJson(Map<String, dynamic> json) {
    return AdminInfor(
      adminCreatedAt: (json['adminCreatedAt'] as Timestamp?),
    );
  }
  Map<String, dynamic> toJson() => {
        'adminCreatedAt': adminCreatedAt,
      };
}
