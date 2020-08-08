import 'package:equatable/equatable.dart';

abstract class PinCodeLockState extends Equatable{
  const PinCodeLockState();
}

class InitialPinCodeLockState extends PinCodeLockState with EquatableMixin{
  InitialPinCodeLockState();
  @override
  List<Object> get props => [];
}

class PinCodeLockErrorState extends PinCodeLockState with EquatableMixin{
  PinCodeLockErrorState();
  @override
  List<Object> get props => [];
}