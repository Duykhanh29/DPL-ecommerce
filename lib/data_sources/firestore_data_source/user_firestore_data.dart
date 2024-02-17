import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/consumer_infor.dart';
import 'package:dpl_ecommerce/models/seller_infor.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirestoreDatabase {
  UserFirestoreDatabase();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const int awardPointForPurchasing = 10;
  static const int awardPontForReview = 5;
  static const int minPointForBronze = 100;
  static const int minPointForSilver = 200;
  static const int minPointForGold = 200;
  // user sections
  Future<void> addUser(UserModel userModel) async {
    try {
      await _firestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateAvatar(
      {required String uid, required String avatar}) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        "avatar": avatar,
      });
    } catch (e) {
      print("This error is: $e");
    }
  }

  Future<void> updateUserInfor(
      {String? avatar,
      String? name,
      String? phone,
      String? email,
      required UserModel userModel}) async {
    String? newEmail = email ?? userModel.email;
    String? newPhone = phone ?? userModel.phone;
    String? newAvatar = avatar ?? userModel.avatar;
    String? newName = name ?? userModel.firstName;
    try {
      await _firestore.collection('users').doc(userModel.id).update({
        "email": newEmail,
        "phone": newPhone,
        "avatar": newAvatar,
        "firstName": newName
      });
    } catch (e) {
      print("This error is: $e");
    }
  }

  Future<bool> isUserExists(String id) async {
    final reasult =
        await _firestore.collection('users').where('id', isEqualTo: id).get();
    return reasult.docs.isNotEmpty;
  }

  Future existedUserCheckWithPhoneOrEmail(
      {String? phone, String? email}) async {
    final reasult = await _firestore
        .collection('users')
        .where('phone', isEqualTo: phone)
        .get();
    final result2 = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (reasult.docs.isNotEmpty && result2.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<UserModel?> getUserModel(User user) async {
    // final isAmdin = await isAdmin(user.uid);
    // Role role = Role.consumer;
    // if (isAmdin) {
    //   role = Role.admin;
    // } else {
    //   role = Role.consumer;
    // }
    UserModel? userModel = await getUserModel1(user.uid);
    return userModel!;
    // return UserModel(
    //     avatar: user.photoURL,
    //     email: user.email,
    //     id: user.uid,
    //     firstName: user.displayName,
    //     role: Role.consumer,
    //     userInfor: UserInfor());
  }

  Future<UserModel?> getUserModel1(String id) async {
    final snapshot =
        await _firestore.collection('users').where('id', isEqualTo: id).get();
    if (snapshot.docs.isNotEmpty) {
      var data = snapshot.docs[0].data();
      return UserModel.fromJson(data);
    }
  }

  Future<bool> isAdmin(String id) async {
    final reasult = await _firestore
        .collection('users')
        .where('id', isEqualTo: id)
        .where('role', isEqualTo: Role.admin)
        .get();
    return reasult.docs.isNotEmpty;
  }

  Future<void> updateRole(String uid, Role newRole) async {
    try {
      await _firestore.collection('users').doc(uid).update({"role": newRole});
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<UserModel>?> getListUser() async {
    try {
      List<UserModel>? list = [];
      final snapshot = await _firestore.collection('users').get();
      if (snapshot.docs.isNotEmpty) {
        for (var data in snapshot.docs) {
          UserModel userModel = UserModel(
              id: data.id,
              avatar: data.data()['avatar'],
              email: data.data()['email'],
              firstName: data.data()['firstName'],
              lastName: data.data()['lastName'],
              phone: data.data()['phone'],
              role: Role.values.firstWhere(
                (element) =>
                    element.toString().split(".").last == data.data()['role'],
                orElse: () => Role.admin,
              ),
              userInfor: UserInfor.fromJson(data.data()['userInfor']));
          list.add(userModel);
        }
        return list;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // address section
  Future<List<AddressInfor>?> getListAddressInfor(String uid) async {
    try {
      final ref = await _firestore.collection('users').doc(uid).get();
      if (ref.exists) {
        List<AddressInfor> result = [];
        List<AddressInfor> addressInfors = [];
        final userData = ref.data();
        if (userData!['userInfor'] != null &&
            userData['userInfor']['consumerInfor'] != null &&
            userData['userInfor']['consumerInfor']['addressInfors'] != null) {
          final addressInforsData = userData['userInfor']['consumerInfor']
              ['addressInfors'] as List<dynamic>;
          addressInfors = addressInforsData
              .map((addressData) => AddressInfor.fromJson(addressData))
              .toList();
        }
        for (var element in addressInfors) {
          if (!element.isDeleted) {
            result.add(element);
          }
        }
        return result;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Stream<List<AddressInfor>?> getAllAddressInfors(String uid) async* {
    try {
      final ref = await _firestore.collection('users').doc(uid).snapshots();
      final StreamController<List<AddressInfor>?> streamController =
          StreamController<List<AddressInfor>?>();
      StreamSubscription streamSubscription = ref.listen((event) {
        List<AddressInfor> addressInfors = [];
        List<AddressInfor> result = [];
        if (event.exists) {
          final userData = event.data();
          if (userData!['userInfor'] != null &&
              userData['userInfor']['consumerInfor'] != null &&
              userData['userInfor']['consumerInfor']['addressInfors'] != null) {
            final addressInforsData = userData['userInfor']['consumerInfor']
                ['addressInfors'] as List<dynamic>;
            print("How many leng: ${addressInforsData.length}");
            addressInfors = addressInforsData
                .map((addressData) => AddressInfor.fromJson(addressData))
                .toList();
          }
          for (var element in addressInfors) {
            if (!element.isDeleted) {
              result.add(element);
            }
          }

          streamController.sink.add(result);
        } else {
          print("Not exists ");
        }
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("Error: $e");
    }
  }

  Stream<AddressInfor?> getAddressInfoForSeller(String uid) async* {
    try {
      final ref = _firestore.collection('users').doc(uid).snapshots();
      final StreamController<AddressInfor> streamController =
          StreamController<AddressInfor>();
      final StreamSubscription streamSubscription = ref.listen((event) {
        if (event.exists) {
          final userData = event.data();
          final userInfor = userData!['userInfor'];
          final sellerInfor = userInfor['sellerInfor'];
          final addressInfo =
              AddressInfor.fromJson(sellerInfor['contactAddress']);
          streamController.sink.add(addressInfo);
        } else {
          streamController.close();
        }
      });
      streamController.onCancel = () {
        streamSubscription.cancel();
        streamController.close();
      };
      yield* streamController.stream;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<AddressInfor?> getAddressForSeller(String uid) async {
    try {
      final ref = await _firestore.collection('users').doc(uid).get();
      if (ref.exists) {
        final data = ref.data();
        final userInfor = data!['userInfor'];
        final sellerInfor = userInfor['sellerInfor'];
        final addressInfo =
            AddressInfor.fromJson(sellerInfor['contactAddress']);
        return addressInfo;
      } else {
        print("Empty");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> addAddress(
      AddressInfor addressInfor, UserModel userModel) async {
    try {
      final userDoc = _firestore.collection('users').doc(userModel.id);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);
        List<AddressInfor> listAdd = [];
        if (user.userInfor != null) {
          if (user.userInfor!.consumerInfor != null) {
            listAdd = user.userInfor!.consumerInfor!.addressInfors ?? [];
          }
        }
        if (addressInfor.isDefaultAddress) {
          for (var element in listAdd) {
            if (element.isDefaultAddress) {
              element.isDefaultAddress = false;
            }
          }
        }
        listAdd.add(addressInfor);
        userModel.userInfor!.consumerInfor!.addressInfors = listAdd;
        await userDoc.update({'userInfor': userModel.userInfor!.toJson()});
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateAddressInfor(
      AddressInfor addressInfor, UserModel userModel) async {
    try {
      final userDoc = _firestore.collection('users').doc(userModel.id);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);
        List<AddressInfor> listAdd = [];
        if (user.userInfor != null) {
          if (user.userInfor!.consumerInfor != null) {
            listAdd = user.userInfor!.consumerInfor!.addressInfors ?? [];
            for (var data in listAdd) {
              if (data.id == addressInfor.id) {
                listAdd.removeWhere((element) => element.id == data.id);
                if (addressInfor.isDefaultAddress) {
                  for (var element in listAdd) {
                    if (element.isDefaultAddress) {
                      element.isDefaultAddress = false;
                    }
                  }
                }
                listAdd.add(addressInfor);
              }
            }

            userModel.userInfor!.consumerInfor!.addressInfors = listAdd;
            await userDoc.update(userModel.toJson());
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateAddressForSeller(
      AddressInfor addressInfor, String uid) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);

        user.userInfor!.sellerInfor!.contactAddress = addressInfor;
        await userDoc.update(user.toJson());
      } else {
        print("EMPTY");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> deleteAddress(String id, UserModel user) async {
    try {
      final userDoc = _firestore.collection('users').doc(user.id);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);
        List<AddressInfor> listAdd = [];
        if (user.userInfor != null) {
          if (user.userInfor!.consumerInfor != null) {
            listAdd = user.userInfor!.consumerInfor!.addressInfors ?? [];
            // listAdd.removeWhere((element) => element.id == id);
            for (var element in listAdd) {
              if (element.id == id) {
                element.isDeleted = true;
                if (listAdd.length > 1 && element.isDefaultAddress) {
                  listAdd[0].isDefaultAddress = true;
                }
              }
            }
            user.userInfor!.consumerInfor!.addressInfors = listAdd;
            await userDoc.update(user.toJson());
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<AddressInfor?> getDefaultAddress(String uid) async {
    try {
      final ref = await _firestore.collection('users').doc(uid).get();
      if (ref.exists) {
        List<AddressInfor> addressInfors = [];
        final userData = ref.data();
        if (userData!['userInfor'] != null &&
            userData['userInfor']['consumerInfor'] != null &&
            userData['userInfor']['consumerInfor']['addressInfors'] != null) {
          final addressInforsData = userData['userInfor']['consumerInfor']
              ['addressInfors'] as List<dynamic>;
          addressInfors = addressInforsData
              .map((addressData) => AddressInfor.fromJson(addressData))
              .toList();
          for (var element in addressInfors) {
            if (element.isDefaultAddress) {
              return element;
            }
          }
        }
      } else {
        print("NOt exists");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // award point and raking
  Future<void> updateAwardPontForPurchasing(String uid) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);
        if (user.userInfor != null) {
          if (user.userInfor!.consumerInfor != null) {
            int awardPoint = user.userInfor!.consumerInfor!.rewardPoints;
            awardPoint = awardPoint + awardPointForPurchasing;
            user.userInfor!.consumerInfor!.rewardPoints = awardPoint;
            if (awardPoint > minPointForGold &&
                user.userInfor!.consumerInfor!.raking != Raking.gold) {
              user.userInfor!.consumerInfor!.raking != Raking.gold;
            } else if (awardPoint > minPointForGold &&
                user.userInfor!.consumerInfor!.raking != Raking.silver) {
              user.userInfor!.consumerInfor!.raking != Raking.silver;
            }
            await userDoc.update(user.toJson());
          }
        }
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updateAwardPontForReview(String uid) async {
    try {
      final userDoc = _firestore.collection('users').doc(uid);
      final snapshot = await userDoc.get();
      if (snapshot.exists) {
        var dataUser = snapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromJson(dataUser);
        List<AddressInfor> listAdd = [];
        if (user.userInfor != null) {
          if (user.userInfor!.consumerInfor != null) {
            int awardPoint = user.userInfor!.consumerInfor!.rewardPoints;
            awardPoint = awardPoint + awardPontForReview;
            user.userInfor!.consumerInfor!.rewardPoints = awardPoint;
            if (awardPoint > minPointForGold &&
                user.userInfor!.consumerInfor!.raking != Raking.gold) {
              user.userInfor!.consumerInfor!.raking != Raking.gold;
            } else if (awardPoint > minPointForGold &&
                user.userInfor!.consumerInfor!.raking != Raking.silver) {
              user.userInfor!.consumerInfor!.raking != Raking.silver;
            }
            await userDoc.update(user.toJson());
          }
        }
      } else {
        print("Not exists");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // seller
  // Future<void> addSellerInfor( {required String })async{
  //   try {
  //     await _firestore.collection('users').
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }
}
