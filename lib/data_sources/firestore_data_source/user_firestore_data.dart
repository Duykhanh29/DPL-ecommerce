import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpl_ecommerce/models/address_infor.dart';
import 'package:dpl_ecommerce/models/shop.dart';
import 'package:dpl_ecommerce/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirestoreDatabase {
  UserFirestoreDatabase();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<void> updateUser(
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
  Stream<List<AddressInfor>?> getAddressInfors(String uid) async* {
    try {
      final ref = await _firestore.collection('users').doc(uid).snapshots();
      final StreamController<List<AddressInfor>?> streamController =
          StreamController<List<AddressInfor>?>();
      StreamSubscription streamSubscription = ref.listen((event) {
        List<AddressInfor> addressInfors = [];
        if (event.exists) {
          final userData = event.data();
          if (userData!['userInfor'] != null &&
              userData['userInfor']['consumerInfor'] != null &&
              userData['userInfor']['consumerInfor']['addressInfors'] != null) {
            final addressInforsData = userData['userInfor']['consumerInfor']
                ['addressInfors'] as List<dynamic>;
            addressInfors = addressInforsData
                .map((addressData) => AddressInfor.fromJson(addressData))
                .toList();
          }
          streamController.sink.add(addressInfors);
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
            listAdd.removeWhere((element) => element.id == id);
            user.userInfor!.consumerInfor!.addressInfors = listAdd;
            await userDoc.update(user.toJson());
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
