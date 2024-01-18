import 'dart:io';

import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:flutter/material.dart';

class ManageSellerViewModel extends ChangeNotifier {
  UserModel? seller;
  VerificationForm? legalInfor;
  Shop? shop;
  String? password;
  String? taxPaperName;
  String? taxPaperPath;
  File? file;
  void setShop(Shop newShop) {
    shop = newShop;
    notifyListeners();
  }

  void setPassword(String string) {
    password = string;
    notifyListeners();
  }

  void setBasicInfo(UserModel userModel) {
    seller = userModel;
    notifyListeners();
  }

  void updateVerification(String url) {
    legalInfor!.taxPaper = url;
    notifyListeners();
  }

  void setLegalInfo(
      {required VerificationForm verificationForm,
      required String path,
      required String name,
      required File newFile}) {
    legalInfor = verificationForm;
    file = newFile;
    taxPaperName = name;
    taxPaperPath = path;
    notifyListeners();
  }

  void reset() {
    seller = null;
    legalInfor = null;
    shop = null;
    taxPaperPath = null;
    taxPaperName = null;
    file = null;
    password = null;
    notifyListeners();
  }
}
