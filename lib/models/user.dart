import 'package:dpl_ecommerce/models/admin_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';

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
      this.userInfor});
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
        userInfor: UserInfor.fromJson(json['userInfor']));
  }
  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'email': email,
        'firstName': firstName,
        'id': id,
        'lastName': lastName,
        'phone': phone,
        'role': role!.toString().split(".").last,
        'userInfor': userInfor!.toJson()
      };
}

class UserInfor {
  AdminInfor? adminInfor;
  ConsumerInfor? consumerInfor;
  SellerInfor? sellerInfor;
  UserInfor({this.adminInfor, this.consumerInfor, this.sellerInfor});
  factory UserInfor.fromJson(Map<String, dynamic> json) {
    return UserInfor(
        adminInfor: AdminInfor.fromJson(json['adminInfor']),
        consumerInfor: ConsumerInfor.fromJson(json['consumerInfor']),
        sellerInfor: SellerInfor.fromJson(json['sellerInfor']));
  }
  Map<String, dynamic> toJson() => {
        'sellerInfor': sellerInfor!.toJson(),
        'consumerInfor': consumerInfor!.toJson(),
        'adminInfor': adminInfor!.toJson()
      };
}
