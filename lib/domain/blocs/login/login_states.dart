import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final String userName;

  LoginInitial({this.userName = ""});

  @override
  List<Object> get props => [userName];
}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final Exception exception;
  final String error;

  LoginFailure({this.exception, this.error});

  @override
  List<Object> get props => [exception, error];
}
