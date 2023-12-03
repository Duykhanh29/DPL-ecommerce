import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  // TextEditingController? emailTextEditting = TextEditingController();
  // TextEditingController? phoneTextEditting = TextEditingController();
  // TextEditingController? firstTextEditting = TextEditingController();
  // TextEditingController? lastTextEdittiing = TextEditingController();
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();
  UserFirestoreDatabase userFirestoreDatabase = UserFirestoreDatabase();
  AuthViewModel? _authViewModel;
  UserModel? userModel;
  UserViewModel(this._authViewModel) {
    userModel = _authViewModel!.currentUser; // _auth null here
  }
  UserModel? get currentUser => userModel;

  final firstNameEditTextController = TextEditingController();
  final lastNameEditTextController = TextEditingController();
  final emailEditTextController = TextEditingController();

  final phoneEditTextController = TextEditingController();
  // address
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final districtController = TextEditingController();
  final longitudeController = TextEditingController();
  final latitudeController = TextEditingController();
  bool isDefaultAddress = false;

  // UserModel userModel = UserModel(
  //     avatar:
  //         "https://letsenhance.io/static/15912da66660b919112b5dfc9f562f6f/f90fb/SC.jpg",
  //     email: "duykhanh0220@gmail.com",
  //     firstName: "Khanh",
  //     id: "userID007",
  //     lastName: "Dang",
  //     phone: "0964651146",
  //     role: Role.consumer,
  //     userInfor: UserInfor(
  //         consumerInfor: ConsumerInfor(addressInfors: [
  //       AddressInfor(
  //           city: "Ha Noi",
  //           country: "Viet Nam",
  //           district: "Ha Dong",
  //           isDefaultAddress: true,
  //           latitude: 123.4,
  //           longitude: 76.45,
  //           name: "My current rental room"),
  //       AddressInfor(
  //           city: "Ha Noi",
  //           country: "Viet Nam",
  //           district: "Thanh Tri",
  //           isDefaultAddress: true,
  //           latitude: 124.4,
  //           longitude: 75.5,
  //           name: "My School"),
  //       AddressInfor(
  //           city: "Tuyen Quang",
  //           country: "Viet Nam",
  //           district: "Son Duong",
  //           isDefaultAddress: true,
  //           latitude: 115.44,
  //           longitude: 68.45,
  //           name: "My hometown"),
  //     ], raking: Raking.gold, rewardPoints: 1000)));

  Future<void> addNewAddress(AddressInfor addressInfor) async {
    userModel!.userInfor!.consumerInfor!.addressInfors!.add(addressInfor);
    await userFirestoreDatabase.addAddress(addressInfor, userModel!);

    notifyListeners();
  }

  void initialize() {
    firstNameEditTextController.text = userModel!.firstName ?? "";
    lastNameEditTextController.text = userModel!.lastName ?? "";
    emailEditTextController.text = userModel!.email ?? "";
    phoneEditTextController.text = userModel!.phone ?? "";
  }

  void initilizeAddress(AddressInfor addressInfor) {
    cityController.text = addressInfor.city!;
    nameController.text = addressInfor.name!;
    countryController.text = addressInfor.country!;
    districtController.text = addressInfor.district!;
    latitudeController.text =
        addressInfor.latitude == null ? "" : addressInfor.latitude.toString();
    longitudeController.text =
        addressInfor.longitude == null ? "" : addressInfor.longitude.toString();
    isDefaultAddress = addressInfor.isDefaultAddress;
    notifyListeners();
  }

  void resetAddress() {
    cityController.text = "";
    nameController.text = "";
    countryController.text = "";
    districtController.text = "";
    latitudeController.text = "";
    longitudeController.text = "";
    isDefaultAddress = false;
    notifyListeners();
  }

  // void changeTempEmail(String newEmail) {
  //   email = newEmail;
  //   notifyListeners();
  // }

  // void changeTempPhone(String newPhone) {
  //   phone = newPhone;
  //   notifyListeners();
  // }

  // void changeTempFirstName(String newFirstName) {
  //   firstName = newFirstName;
  //   notifyListeners();
  // }

  // void changeTempLastName(String newLastName) {
  //   lastName = newLastName;
  //   notifyListeners();
  // }

  void updateInfor({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    if (firstName != null) {
      userModel!.firstName = firstName;
    }
    if (lastName != null) {
      userModel!.lastName = lastName;
    }
    if (email != null) {
      userModel!.email = email;
    }
    if (phone != null) {
      userModel!.phone = phone;
    }
    notifyListeners();
  }

  void removeAddress(AddressInfor addressInfor) {}
}
