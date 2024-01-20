import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/manage_firestore_data.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/verification_form.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:flutter/material.dart';

class VerificationFormRepo {
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  ManageFirestoreData manageFirestoreData = ManageFirestoreData();
  Future<List<VerificationForm>?> getListVerificationForm() async {
    return await firestoreDatabase.getListVerificationForm();
  }

  Future<VerificationForm?> getVerificationFormByID(String id) async {
    return await firestoreDatabase.getVerificationFormByID(id);
  }

  Future<bool?> isVerificatioinFormExist(String shopID) async {
    return await firestoreDatabase.isVerificatioinFormExist(shopID);
  }

  //admin actions
  Future<void> confirmSellerRequest(VerificationForm verificationForm) async {
    await firestoreDatabase.confirmSellerRequest(verificationForm);
  }

  Future<void> addSellerByAdmin(
      {required String email,
      required String pass,
      required String firstName,
      required City city,
      required District disctrict,
      required Ward ward,
      required String country,
      required String number,
      required String shopName,
      required BuildContext context}) async {
    await manageFirestoreData.addSellerByAdmin(
        email: email,
        pass: pass,
        firstName: firstName,
        city: city,
        disctrict: disctrict,
        ward: ward,
        country: country,
        number: number,
        shopName: shopName,
        context: context);
  }

  // shop send
  Future<void> sendVerificationForm(VerificationForm verificationForm) async {
    await firestoreDatabase.sendVerificationForm(
        verificationForm: verificationForm);
  }

  // statistic
  Future<List<UserModel>?> getListVerifiedSeller() async {
    return firestoreDatabase.getListVerifiedSeller();
  }

  Future<List<UserModel>?> getListUnVerifiedSeller() async {
    return firestoreDatabase.getListUnVerifiedSeller();
  }

  // Future<List<UserModel>?> getListDeniedSeller() async {
  //   return firestoreDatabase.getListDeniedSeller();
  // }
}
