import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';

class UserViewModel extends ChangeNotifier {
  // TextEditingController? emailTextEditting = TextEditingController();
  // TextEditingController? phoneTextEditting = TextEditingController();
  // TextEditingController? firstTextEditting = TextEditingController();
  // TextEditingController? lastTextEdittiing = TextEditingController();
  FirestoreDatabase _firestoreDatabase = FirestoreDatabase();
  UserFirestoreDatabase userFirestoreDatabase = UserFirestoreDatabase();
  AuthViewModel? _authViewModel = AuthViewModel();

  UserModel? userModel;
  Shop? shop;
  UserViewModel(this._authViewModel) {
    userModel = _authViewModel!.currentUser; // _auth null here
    // if (userModel != null) {
    //   if (userModel!.role == Role.seller) {}
    // }

    print(_authViewModel!.userModel);
  }
  Shop? get currentShop => shop;
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
  final wardController = TextEditingController();
  final homeNumberController = TextEditingController();
  bool isDefaultAddress = false;
  City? selected_city;

  District? selected_district;

  Ward? selected_ward;

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
    selected_city = addressInfor.city;
    selected_district = addressInfor.district;
    selected_ward = addressInfor.ward;
    nameController.text = addressInfor.name!;
    isDefaultAddress = addressInfor.isDefaultAddress;
    countryController.text = addressInfor.country ?? "";
    notifyListeners();
  }

  void resetAddress() {
    cityController.text = "";
    nameController.text = "";
    countryController.text = "";
    districtController.text = "";
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

  void updateAvatar(String newAvatar) {
    userModel!.avatar = newAvatar;
    notifyListeners();
  }

  void removeAddress(AddressInfor addressInfor) {}
}
