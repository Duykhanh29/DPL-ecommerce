import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/district.dart';
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
            city: City(id: "8", name: "Tuyen Quang"),
            country: "Viet Nam",
            isDefaultAddress: true,
            latitude: 123,
            longitude: 150,
            name: "My home",
            district: District(id: "123", name: "Hoang Mai")),
        AddressInfor(
            city: City(id: "8", name: "Tuyen Quang"),
            country: "Viet Nam",
            isDefaultAddress: false,
            latitude: 140,
            longitude: 180,
            name: "My school",
            district: District(id: "123", name: "Hoang Mai")),
      ], raking: Raking.gold, rewardPoints: 100),
    ),
  );
}
