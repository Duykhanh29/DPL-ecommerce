import 'package:dpl_ecommerce/models/admin_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:uuid/uuid.dart';

enum Role { admin, consumer, seller, mixedUser }

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? avatar;
  Role? role;
  UserInfor? userInfor;
  UserModel(
      {this.avatar,
      this.email,
      this.firstName,
      this.id,
      this.lastName,
      this.phone,
      this.role,
      this.userInfor}) {
    id ??= Uuid().v4();
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        avatar: json['avatar'],
        email: json['email'],
        firstName: json['firstName'],
        id: json['id'],
        lastName: json['lastName'],
        phone: json['phone'],
        role: Role.values.firstWhere(
          (element) => element.toString().split(".").last == json['role'],
          orElse: () => Role.admin,
        ),
        userInfor: json['userInfor'] == null
            ? null
            : UserInfor.fromJson(json['userInfor']));
  }
  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'email': email,
        'firstName': firstName,
        'id': id,
        'lastName': lastName,
        'phone': phone,
        'role': role!.toString().split(".").last,
        'userInfor': userInfor != null ? userInfor!.toJson() : null
      };
}

class UserInfor {
  AdminInfor? adminInfor;
  ConsumerInfor? consumerInfor;
  SellerInfor? sellerInfor;
  UserInfor({this.adminInfor, this.consumerInfor, this.sellerInfor});
  factory UserInfor.fromJson(Map<String, dynamic> json) {
    return UserInfor(
        adminInfor: json['adminInfor'] == null
            ? null
            : AdminInfor.fromJson(json['adminInfor']),
        consumerInfor: json['consumerInfor'] == null
            ? null
            : ConsumerInfor.fromJson(json['consumerInfor']),
        sellerInfor: json['sellerInfor'] == null
            ? null
            : SellerInfor.fromJson(json['sellerInfor']));
  }
  Map<String, dynamic> toJson() => {
        'sellerInfor': sellerInfor != null ? sellerInfor!.toJson() : null,
        'consumerInfor': consumerInfor != null ? consumerInfor!.toJson() : null,
        'adminInfor': adminInfor != null ? adminInfor!.toJson() : null
      };
}
