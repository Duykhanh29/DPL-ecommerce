import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManageFirestoreData {
  ManageFirestoreData();
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  UserFirestoreDatabase userFirestoreDatabase = UserFirestoreDatabase();
  final FirebaseAuth auth = FirebaseAuth.instance;
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
    UserCredential result =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);

    if (result == null) {
      print("Account created failed");
    } else {
      var isExist = await userFirestoreDatabase
          .existedUserCheckWithPhoneOrEmail(email: email);
      if (isExist) {
        print("Exist");
        // userModel = await userFirestoreDatabase
        //     .getUserModel1(result.user!.uid);
      } else {
        // bool isEmailVerified = auth.currentUser!.emailVerified;
        // if (!isEmailVerified) {
        //   // sendVerificationEmail();
        //   final user = auth.currentUser!;
        //   user.sendEmailVerification();
        //   timer = Timer.periodic(Duration(seconds: 3), (timer) async {
        //     await auth.currentUser!.reload();
        //     bool isEmailVerified = auth.currentUser!.emailVerified;
        //     notifyListeners();
        //     if (isEmailVerified) {
        //       timer.cancel();

        Shop shop = Shop(
          name: shopName,
          addressInfor: AddressInfor(
              city: city,
              country: country,
              district: disctrict,
              number: number,
              ward: ward,
              isDefaultAddress: true),
        );
        AddressInfor add = AddressInfor(
            city: city,
            country: country,
            district: disctrict,
            number: number,
            ward: ward,
            isDefaultAddress: true);
        UserModel user = UserModel(
          id: result.user!.uid,
          email: email,
          firstName: firstName,
          role: Role.seller,
          avatar: result.user!.photoURL,
          userInfor: UserInfor(
            sellerInfor: SellerInfor(
              shopIDs: [shop.id!],
              contactAddress: add,
              isVerified: false,
            ),
          ),
        );
        await firestoreDatabase.addShop(shop);
        await userFirestoreDatabase.addUser(user);
        //   }
        // });
        // }
        // await userFirestoreDatabase.
      }
    }
  }

  Future<void> dispose() async {
    await firestoreDatabase.dispose();
  }
}
