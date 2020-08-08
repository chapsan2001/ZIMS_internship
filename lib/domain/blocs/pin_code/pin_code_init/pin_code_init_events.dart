import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class PinCodeInitEvent extends Equatable {
  const PinCodeInitEvent();
}

class EnteredFirstTimeEvent extends PinCodeInitEvent {
  final List<int> pinEnter;
  EnteredFirstTimeEvent({@required this.pinEnter});
  @override
  List<Object> get props => [pinEnter];
}

class EnteredSecondTimeEvent extends PinCodeInitEvent {
  final List<int> pinEnter;
  EnteredSecondTimeEvent({@required this.pinEnter});
  @override
  List<Object> get props => [pinEnter];
}

class EnteredWrongPinEvent extends PinCodeInitEvent{
  @override
  List<Object> get props => [];
}

class SkippedPinInitializationEvent extends PinCodeInitEvent{
  final bool isSkipped;
  SkippedPinInitializationEvent({@required this.isSkipped});
  @override
  List<Object> get props => [isSkipped];
}