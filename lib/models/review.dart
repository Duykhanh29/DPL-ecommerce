// ignore_for_file: prefer_null_aware_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum ResourseType { image, video }

class Review {
  String? id;
  String? productID;
  String? userID;
  double? rating;
  String? userAvatar;
  String? userName;
  String? text;
  Timestamp? time;
  ResourseType? resourseType;
  String? urlMedia;
  Review(
      {this.id,
      this.productID,
      this.rating,
      this.resourseType,
      this.text,
      this.time,
      this.userAvatar,
      this.userID,
      this.urlMedia,
      this.userName}) {
    id ??= Uuid().v4();
  }
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        urlMedia: json['urlMedia'],
        productID: json['productID'],
        rating: json['rating'],
        resourseType: json['resourseType'] == null
            ? null
            : ResourseType.values.firstWhere((element) =>
                element.toString().split(".").last == json['resourseType']),
        id: json['id'],
        text: json['text'],
        userAvatar: json['userAvatar'],
        userID: json['userID'],
        time: (json['time'] as Timestamp?),
        userName: json['userName']);
  }
  Map<String, dynamic> toJson() => {
        'productID': productID,
        'rating': rating,
        'resourseType': resourseType != null
            ? resourseType.toString().split(".").last
            : null,
        'id': id,
        'text': text,
        'userAvatar': userAvatar,
        'userID': userID,
        'time': time,
        'urlMedia': urlMedia,
        'userName': userName
      };
}
