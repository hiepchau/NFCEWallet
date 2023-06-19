import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class RequestFactory {
  RequestFactory();
  createLogin(String username, String password) {
    return {
      "username": username,
      "password": password
    };
  }

  createRegister(String fullName, String password, String phone, String identifyID, String dob) {
    return {
      "full_name": fullName,
      "password": password,
      "phone_number": phone,
      "identify_ID": identifyID,
      "birthday": dob
    };
  }

  createOtp(String otp, String phone) {
    return {
      "otp": otp,
      "phone_number": phone
    };
  }

  changePassword(String oldPassword, String newPassword) {
    return {
      "old_password": oldPassword,
      "new_password": newPassword
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

  createTransferTransaction(String fromUser, String toUser, String amount, String message){
    return {
      "from_User": fromUser,
      "to_User": toUser,
      "amount": amount,
      "message": message
    };
  }

  createTransaction(String fromUser, String toUser, String amount, String message, String type){
    return {
      "from_User": fromUser,
      "to_User": toUser,
      "amount": amount,
      "message": message,
      "type": type
    };
  }

  createWallet(String name, String type, String cardNumber){
    return {
      "name": name,
      "type": type,
      "card_number": cardNumber,
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