import 'package:equatable/equatable.dart';

abstract class PinCodeInitState extends Equatable {
  const PinCodeInitState();
}

class InitialPinCodeInitState extends PinCodeInitState with EquatableMixin{
  InitialPinCodeInitState();
  @override
  List<Object> get props => [];
}

class PinCodeInitErrorState extends PinCodeInitState with EquatableMixin{
  PinCodeInitErrorState();
  @override
  List<Object> get props => [];
}

class EnterPinSecondTimeState extends PinCodeInitState with EquatableMixin{
  EnterPinSecondTimeState();
  @override
  List<Object> get props => [];
}