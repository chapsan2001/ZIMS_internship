import 'package:equatable/equatable.dart';

abstract class PinCodeLockEvent extends Equatable {
  const PinCodeLockEvent();
}

class EnteredWrongPinEvent extends PinCodeLockEvent{
  final int attempts;
  EnteredWrongPinEvent({this.attempts});
  @override
  List<Object> get props => [];
}

class LoggedOutEvent extends PinCodeLockEvent{
  final bool isLogout;
  LoggedOutEvent({this.isLogout});
  @override
  List<Object> get props => [isLogout];
}

class UnlockedEvent extends PinCodeLockEvent{
  @override
  List<Object> get props => [];
}