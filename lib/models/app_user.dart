import 'package:flutter/cupertino.dart';

class AppUser extends ChangeNotifier{
  String? appUserId;
  String? userName;
  String? userEmail;
  bool? isFirstLogin;
  String? createdAt;
  String? password;
  String? gender;
  double? height;
  double? weight;
  int? age;
  AppUser({
    this.appUserId,
    this.userEmail,
    this.userName,
    this.isFirstLogin,
    this.createdAt,
    this.password,
    this.gender,
    this.height,
    this.weight,
    this.age,
  });
  AppUser.fromJson(json, id) {
    appUserId = id;
    userName = json['userName'] ?? '';
    userEmail = json['userEmail'];
    isFirstLogin = json['isFirstLogin'];
    createdAt = json['createdAt'];
    gender=json['gender'];
    height=json['height'];
    weight=json['weight'];
    age=json['age'];
  }

  toJson() {
    return {
      'appUserId': appUserId,
      'userName': userName,
      'userEmail': userEmail,
      'isFirstLogin': isFirstLogin,
      'createdAt': createdAt,
      'gender' : gender,
      'height': height,
      'weight': weight,
      'age': age,
    };
  }
}