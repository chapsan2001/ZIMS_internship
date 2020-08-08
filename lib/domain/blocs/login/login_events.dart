import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {}

class LoginButtonPressed extends LoginEvent {
  final String userName;
  final String password;

  LoginButtonPressed({@required this.userName, @required this.password});

  @override
  List<Object> get props => [userName, password];
}

class LoginLoadPreviousUserName extends LoginEvent {
  @override
  List<Object> get props => [];
}
