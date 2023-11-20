import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  // TextEditingController? emailTextEditting = TextEditingController();
  // TextEditingController? phoneTextEditting = TextEditingController();
  // TextEditingController? firstTextEditting = TextEditingController();
  // TextEditingController? lastTextEdittiing = TextEditingController();
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  UserModel userModel = UserModel(
      avatar:
          "https://letsenhance.io/static/15912da66660b919112b5dfc9f562f6f/f90fb/SC.jpg",
      email: "duykhanh0220@gmail.com",
      firstName: "Khanh",
      id: "userID007",
      lastName: "Dang",
      phone: "0964651146",
      role: Role.consumer,
      userInfor: UserInfor(
          consumerInfor: ConsumerInfor(addressInfors: [
        AddressInfor(
            city: "Ha Noi",
            country: "Viet Nam",
            district: "Ha Dong",
            isDefaultAddress: true,
            latitude: 123.4,
            longitude: 76.45,
            name: "My current rental room"),
        AddressInfor(
            city: "Ha Noi",
            country: "Viet Nam",
            district: "Thanh Tri",
            isDefaultAddress: true,
            latitude: 124.4,
            longitude: 75.5,
            name: "My School"),
        AddressInfor(
            city: "Tuyen Quang",
            country: "Viet Nam",
            district: "Son Duong",
            isDefaultAddress: true,
            latitude: 115.44,
            longitude: 68.45,
            name: "My hometown"),
      ], raking: Raking.gold, rewardPoints: 1000)));
  void addNewAddress(AddressInfor addressInfor) {
    userModel.userInfor!.consumerInfor!.addressInfors!.add(addressInfor);
    notifyListeners();
  }

  void initilize() {
    // emailTextEditting!.text = userModel.email!;
    // phoneTextEditting!.text = userModel.phone!;
    // firstTextEditting!.text = userModel.firstName!;
    // lastTextEdittiing!.text = userModel.lastName!;
    email = userModel.email;
    phone = userModel.phone;
    firstName = userModel.firstName;
    lastName = userModel.lastName;
    // notifyListeners();
  }

  void changeTempEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void changeTempPhone(String newPhone) {
    phone = newPhone;
    notifyListeners();
  }

  void changeTempFirstName(String newFirstName) {
    firstName = newFirstName;
    notifyListeners();
  }

  void changeTempLastName(String newLastName) {
    lastName = newLastName;
    notifyListeners();
  }

  void updateInfor({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    if (firstName != null) {
      userModel.firstName = firstName;
    }
    if (lastName != null) {
      userModel.lastName = lastName;
    }
    if (email != null) {
      userModel.email = email;
    }
    if (phone != null) {
      userModel.phone = phone;
    }
    notifyListeners();
  }

  void removeAddress(AddressInfor addressInfor) {}
}
