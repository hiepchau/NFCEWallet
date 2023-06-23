part of 'deposit_bloc.dart';

class DepositState  {
  final String amount;
  const DepositState({this.amount =""});

  DepositState copyWith({String? amount}){
    return DepositState(amount: amount ?? this.amount);
  }

}

class DepositInitial extends DepositState {}
