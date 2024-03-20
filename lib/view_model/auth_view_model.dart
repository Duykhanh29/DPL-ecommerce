import 'dart:async';

import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/helpers/toast_helper.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/city.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/district.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:dpl_ecommerce/models/ward.dart';
import 'package:dpl_ecommerce/utils/lang/lang_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Timer? timer;
  User? user;
  FirestoreDatabase firestoreDatabase = FirestoreDatabase();
  UserFirestoreDatabase userFirestoreDatabase = UserFirestoreDatabase();
  UserModel? userModel;
  UserModel? get currentUser => userModel;
  Stream<User?> get authStateChanges => auth.authStateChanges();
  AuthViewModel() {
    user = auth.currentUser;
    if (user != null) {
      fetchUser();
    }
    // notifyListeners();
  }
  Future<void> fetchUser() async {
    try {
      userModel = await userFirestoreDatabase.getUserModel(user!);
      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      UserCredential? userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await auth.signInWithProvider(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = (await _googleSignIn.signIn());
        if (googleUser != null) {
          try {
            final GoogleSignInAuthentication googleAuth =
                await googleUser.authentication;
            final AuthCredential credential = GoogleAuthProvider.credential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken);
            userCredential = await auth.signInWithCredential(credential);
          } catch (e) {
            print(e);
          }
        }
      }
      if (userCredential == null) {
        print("object");
      } else {
        var isExist =
            await userFirestoreDatabase.isUserExists(userCredential.user!.uid);
        if (isExist) {
          print("Exist");
          userModel = await userFirestoreDatabase
              .getUserModel1(userCredential.user!.uid);
        } else {
          // userModel =
          //     await userFirestoreDatabase.getUserModel(userCredential.user!);
          userModel = UserModel(
              id: userCredential.user!.uid,
              avatar: userCredential.user!.photoURL!,
              email: userCredential.user!.email,
              firstName: userCredential.user!.displayName,
              role: Role.consumer,
              userInfor: UserInfor(
                  consumerInfor: ConsumerInfor(
                addressInfors: [],
                raking: Raking.bronze,
                rewardPoints: 100,
              )));
          await userFirestoreDatabase.addUser(userModel!);
        }
        notifyListeners();
      }
    } catch (e) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.an_error_has_occurred}: $e",
          gravity: ToastGravity.BOTTOM);
      print("The error is here: $e");
    }
  }

  Future<void> registerUserByEmailAndPass(
      {required String email,
      required String password,
      required BuildContext context,
      required String name}) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

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
          UserModel user = UserModel(
            id: result.user!.uid,
            email: email,
            firstName: name,
            role: Role.consumer,
            userInfor: UserInfor(
                consumerInfor: ConsumerInfor(
              addressInfors: [],
              raking: Raking.bronze,
              rewardPoints: 100,
            )),
          );
          await userFirestoreDatabase.addUser(user);
          userModel = user;
          //   }
          // });
          // }
          // await userFirestoreDatabase.
        }
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastHelper.showDialog(
            LangText(context: context)
                .getLocal()!
                .password_must_contain_at_least_6_characters,
            gravity: ToastGravity.BOTTOM);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ToastHelper.showDialog(
            LangText(context: context)
                .getLocal()!
                .email_provided_already_exists,
            gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.an_error_has_occurred}: $e",
          gravity: ToastGravity.BOTTOM);
      print("The error is here: $e");
    }
  }

  Future signInWithEmailAndPass(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (result == null) {
        // ToastHelper.showDialog(
        //     "${LangText(context: context).getLocal()!.account_is_not_registered}",
        //     gravity: ToastGravity.BOTTOM);
      } else {
        userModel = await userFirestoreDatabase.getUserModel1(result.user!.uid);
      }
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastHelper.showDialog(
            "${LangText(context: context).getLocal()!.account_is_not_registered}",
            gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'wrong-password') {
        ToastHelper.showDialog(
            "${LangText(context: context).getLocal()!.incorrect_pass}",
            gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.an_error_has_occurred}: $e",
          gravity: ToastGravity.BOTTOM);
      print("The error is here OKE OKE OKE: $e");
    }
  }
  // Future<void> registerForCustomerByEMailAndPass({required String email, required String pass,
  //     required String firstName,required BuildContext context})async{
  //       try {
  //          UserCredential result = await auth.createUserWithEmailAndPassword(
  //         email: email, password: pass);

  //       }on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       ToastHelper.showDialog(
  //           LangText(context: context)
  //               .getLocal()!
  //               .password_must_contain_at_least_6_characters,
  //           gravity: ToastGravity.BOTTOM);
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     SnackBar(content: Text('Password Provided is too weak')));
  //     } else if (e.code == 'email-already-in-use') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Email Provided already Exists')));
  //     } catch (e) {

  //       }
  //     }
  Future<void> registerForSellerByEmaillAndPass(
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
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

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
          userModel = user;
          //   }
          // });
          // }
          // await userFirestoreDatabase.
        }
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastHelper.showDialog(
            LangText(context: context)
                .getLocal()!
                .password_must_contain_at_least_6_characters,
            gravity: ToastGravity.BOTTOM);
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('Password Provided is too weak')));
      } else if (e.code == 'email-already-in-use') {
        ToastHelper.showDialog(
            LangText(context: context)
                .getLocal()!
                .email_provided_already_exists,
            gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.an_error_has_occurred}: $e",
          gravity: ToastGravity.BOTTOM);
      print("The error is here: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      userModel = null;
      notifyListeners();
      print("AUh: ${auth.currentUser}");
    } catch (e) {
      print("The error is here: $e");
    }
  }

  Future signInWithPhone(String phone) async {
    if (kIsWeb) {
      ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber('+44 7123 123 456');
      UserCredential userCredential =
          await confirmationResult.confirm('123456');
    } else {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = 'xxxx';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final use = auth.currentUser;
      await user!.sendEmailVerification();
    } catch (e) {
      print("The error is here: $e");
    }
  }

  Future sendPasswordReset(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      ToastHelper.showDialog(
          "${LangText(context: context).getLocal()!.an_error_has_occurred}: $e");
    }
  }
}
