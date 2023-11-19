import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';

class AuthRepo {
  final UserModel user = UserModel(
    avatar:
        "https://letsenhance.io/static/15912da66660b919112b5dfc9f562f6f/f90fb/SC.jpg",
    email: "duykhanh@gmail.com",
    firstName: "Khanh",
    id: "userID100",
    lastName: "Dang",
    phone: "07654321",
    role: Role.consumer,
    userInfor: UserInfor(
      consumerInfor: ConsumerInfor(addressInfors: [
        AddressInfor(
            city: "Ha Noi",
            country: "Viet Nam",
            isDefaultAddress: true,
            latitude: 123,
            longitude: 150,
            name: "My home",
            district: "Ha Dong"),
        AddressInfor(
            city: "Ha Noi",
            country: "Viet Nam",
            isDefaultAddress: false,
            latitude: 140,
            longitude: 180,
            name: "My school",
            district: "Thanh Tri"),
      ], raking: Raking.gold, rewardPoints: 100),
    ),
  );
}
