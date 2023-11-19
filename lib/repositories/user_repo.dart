import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/admin_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';

class UserRepo {
  final List<UserModel> listUser = [
    UserModel(
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
    ),
    UserModel(
      avatar:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH5EdtTOfWycW0RtC7QebmHxZt2BJTEJVZ8FzVzukTls7PCtZbIccqfyhpcGPVQJxQEuk&usqp=CAU",
      email: "duykhanh01@gmail.com",
      firstName: "Khanh01",
      id: "userID01",
      lastName: "Dang",
      phone: "0765432121",
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
              district: "Thanh Xuan"),
        ], raking: Raking.gold, rewardPoints: 90),
      ),
    ),
    UserModel(
      avatar:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSH5EdtTOfWycW0RtC7QebmHxZt2BJTEJVZ8FzVzukTls7PCtZbIccqfyhpcGPVQJxQEuk&usqp=CAU",
      email: "duykhanh03@gmail.com",
      firstName: "KhanhMeo",
      id: "userID02",
      lastName: "Dang",
      phone: "076541111",
      role: Role.mixedUser,
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
                district: "Thanh Xuan"),
          ], raking: Raking.gold, rewardPoints: 90),
          sellerInfor: SellerInfor(
              contactAddress: AddressInfor(
                  city: "Ha Noi",
                  country: "Viet Nam",
                  isDefaultAddress: false,
                  latitude: 140,
                  longitude: 130,
                  name: "My Shop Address",
                  district: "Thanh Tri"),
              isVerified: true,
              licenseNo: "LicenseNo01",
              shopIDs: ["shopID01", "shopID02"],
              taxPaper: "taxPaper01")),
    ),
    UserModel(
      avatar:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV_B48Xod2O9ZfMUIVKoEgOOFD09cwJfM4EGXpcjEwxlhDf4mcXYdqfMNCbFf-FHp74FY&usqp=CAU",
      email: "duykhanh05@gmail.com",
      firstName: "MTH",
      id: "userID03",
      lastName: "D",
      phone: "076541151",
      role: Role.mixedUser,
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
                district: "Thanh Xuan"),
          ], raking: Raking.gold, rewardPoints: 90),
          sellerInfor: SellerInfor(
              contactAddress: AddressInfor(
                  city: "Ha Noi",
                  country: "Viet Nam",
                  isDefaultAddress: false,
                  latitude: 140,
                  longitude: 100,
                  name: "My Shop Address",
                  district: "Thanh Tri"),
              isVerified: true,
              licenseNo: "LicenseNo02",
              shopIDs: ["shopID03", "shopID04"],
              taxPaper: "taxPaper02")),
    ),
    UserModel(
      avatar: "https://i.ytimg.com/vi/7oIAs-0G4mw/maxresdefault.jpg",
      email: "duykhanh06@gmail.com",
      firstName: "Khanh Admin",
      id: "userID04",
      lastName: "Dang",
      phone: "07654321",
      role: Role.admin,
      userInfor: UserInfor(
          adminInfor: AdminInfor(
              adminCreatedAt:
                  DateTime.now().subtract(const Duration(days: 29)))),
    ),
    UserModel(
      avatar:
          "https://help.apple.com/assets/640A717137F1F367FD068392/640A717137F1F367FD068399/en_US/506a2faf4b87ede7a358bed134342968.png",
      email: "duykhanh@gmail.com",
      firstName: "KhanhOi",
      id: "userID100",
      lastName: "Dang",
      phone: "07654322221",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(addressInfors: [
          AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 70,
              longitude: 150,
              name: "My home",
              district: "Hai Ba Trung"),
          AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 80,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri"),
        ], raking: Raking.silver, rewardPoints: 100),
      ),
    ),
    UserModel(
      avatar:
          "https://ps.w.org/image-comparison/assets/icon-256x256.png?rev=2587037",
      email: "duy@gmail.com",
      firstName: "Duy",
      id: "userID05",
      lastName: "Dang",
      phone: "07654321",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 123,
              longitude: 150,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 140,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri",
            ),
          ],
          raking: Raking.bronze,
          rewardPoints: 100,
        ),
      ),
    ),
    UserModel(
      avatar:
          "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/317126013/original/43ff860ec00d78673e458de6acba4644a58ace45/draw-an-drawing-on-an-ipad.png",
      email: "duy01@gmail.com",
      firstName: "Khanh",
      id: "userID06",
      lastName: "Dang",
      phone: "07654321",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 65,
              longitude: 150,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 43,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri",
            ),
          ],
          raking: Raking.silver,
          rewardPoints: 100,
        ),
      ),
    ),
    UserModel(
      avatar:
          "https://imgv3.fotor.com/images/side/Edit-image-sharpness-using-Fotors-image-sharpening-tool.jpg",
      email: "mth@gmail.com",
      firstName: "Ha",
      id: "userID07",
      lastName: "Dang",
      phone: "0765432541",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 123,
              longitude: 111,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 111,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri",
            ),
          ],
          raking: Raking.gold,
          rewardPoints: 100,
        ),
      ),
    ),
    UserModel(
      avatar:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvLBeyiTK43-GuQIcW6nDgK1lQ0alyy6K1eTrOoToroXz9lp2kDjQVz2VAMBKLvUZWu3k&usqp=CAU",
      email: "duy03@gmail.com",
      firstName: "Duy03",
      id: "userID08",
      lastName: "Dang",
      phone: "07654321",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 123,
              longitude: 150,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 140,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri",
            ),
          ],
          raking: Raking.bronze,
          rewardPoints: 100,
        ),
      ),
    ),
    UserModel(
      avatar:
          "https://letsenhance.io/static/15912da66660b919112b5dfc9f562f6f/f90fb/SC.jpg",
      email: "duykhanh@gmail.com",
      firstName: "Khanh",
      id: "userID09",
      lastName: "Dang",
      phone: "07654321",
      role: Role.mixedUser,
      userInfor: UserInfor(
          consumerInfor: ConsumerInfor(
            addressInfors: [
              AddressInfor(
                city: "Ha Noi",
                country: "Viet Nam",
                isDefaultAddress: true,
                latitude: 123,
                longitude: 150,
                name: "My home",
                district: "Ha Dong",
              ),
              AddressInfor(
                city: "Ha Noi",
                country: "Viet Nam",
                isDefaultAddress: false,
                latitude: 140,
                longitude: 180,
                name: "My school",
                district: "Thanh Tri",
              ),
            ],
            raking: Raking.gold,
            rewardPoints: 100,
          ),
          sellerInfor: SellerInfor(
              contactAddress: AddressInfor(
                city: "Ha Noi",
                country: "Viet Nam",
                isDefaultAddress: false,
                latitude: 140,
                longitude: 180,
                name: "My Home address",
                district: "Thanh Nam",
              ),
              isVerified: false,
              licenseNo: "licenseNo03",
              shopIDs: ["shopID06"],
              taxPaper: "taxPaper03")),
    ),
    UserModel(
      avatar:
          "https://d38b044pevnwc9.cloudfront.net/cutout-nuxt/enhancer/3.jpg",
      email: "mtha@gmail.com",
      firstName: "Thu Ha",
      id: "userID10",
      lastName: "Dang",
      phone: "0765432231",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 54,
              longitude: 65,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 140,
              longitude: 345,
              name: "My school",
              district: "Thanh Mai",
            ),
          ],
          raking: Raking.bronze,
          rewardPoints: 100,
        ),
      ),
    ),
    UserModel(
      avatar: "https://www.w3schools.com/css/img_5terre_wide.jpg",
      email: "d@gmail.com",
      firstName: "Trung",
      id: "userID11",
      lastName: "Phan",
      phone: "07654321897",
      role: Role.consumer,
      userInfor: UserInfor(
        consumerInfor: ConsumerInfor(
          addressInfors: [
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: true,
              latitude: 123,
              longitude: 150,
              name: "My home",
              district: "Ha Dong",
            ),
            AddressInfor(
              city: "Ha Noi",
              country: "Viet Nam",
              isDefaultAddress: false,
              latitude: 140,
              longitude: 180,
              name: "My school",
              district: "Thanh Tri",
            ),
          ],
          raking: Raking.silver,
          rewardPoints: 100,
        ),
      ),
    ),
  ];
}
