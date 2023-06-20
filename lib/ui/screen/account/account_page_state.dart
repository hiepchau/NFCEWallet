part of 'account_page_bloc.dart';

@immutable
abstract class AccountPageState {}

class AccountPageInitial extends AccountPageState {}

class AccountLogoutInProgress extends AccountPageState {}

class AccountLogoutSuccess extends AccountPageState {}