import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestFactory {
  RequestFactory();
  createLogin(String username, String password) {
    return {
      "username": username,
      "password": password,
      "device": "mobile"
    };
  }

  createRegister(String username, String password,String email, String firstname, String lastname,String phone, String address,int gender) {
    return {
      "username": username,
      "password": password,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "phonenumber": phone,
      "address": address,
      "gender": gender
    };
  }

  updateUser(String username,String email, String firstname, String lastname,String phone, String address,int gender){
    return {
      "username": username,
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "phonenumber": phone,
      "address": address,
      "gender": gender
    };
  }

  updateUserPassWord(String password){
    return {
      "password": password,
    };
  }

  updateAvatar(FormData path){
    return {
      "file": path,
    };
  }
}