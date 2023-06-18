part of 'signup_bloc.dart';

@immutable
abstract class absSignupEvent {}

class SignupEvent extends absSignupEvent{
  String? fullName, password, phone, identifyID;
  DateTime? dob;
  SignupEvent({
    required this.fullName,
    required this.password,
    required this.phone,
    required this.identifyID,
    required this.dob,});
}

