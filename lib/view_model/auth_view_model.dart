import 'package:dpl_ecommerce/data_sources/firestore_data_source/firestore_data.dart';
import 'package:dpl_ecommerce/data_sources/firestore_data_source/user_firestore_data.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
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
    notifyListeners();
  }
  Future<void> fetchUser() async {
    try {
      userModel = await userFirestoreDatabase.getUserModel(user!);
      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future signInWIthGoogle() async {
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
          userModel =
              await userFirestoreDatabase.getUserModel(userCredential.user!);
          await userFirestoreDatabase.addUser(userModel!);
        }
        notifyListeners();
      }
    } catch (e) {
      print("The error is here: $e");
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
    } catch (e) {
      print(e);
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
}
