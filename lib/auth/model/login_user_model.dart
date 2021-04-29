import 'package:flutter/cupertino.dart';

class LoginUserModel {
  String email;
  String password;

  LoginUserModel({
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    return new LoginUserModel(
      email: map['login'] as String,
      password: map['password'] as String,
    );
  }
}
