import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_init/pin_code_init_events.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_init/pin_code_init_states.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/main.dart';

class PinCodeInitBloc extends Bloc<PinCodeInitEvent, PinCodeInitState> {
  final NavigationManager navigationManager;

  PinCodeInitBloc({@required this.navigationManager});

  @override
  PinCodeInitState get initialState => InitialPinCodeInitState();

  @override
  Stream<PinCodeInitState> mapEventToState(PinCodeInitEvent event) async* {
    if (event is EnteredFirstTimeEvent) {
      yield* _mapEnteredFirstTimeEventToState(event);
    } else if (event is EnteredSecondTimeEvent) {
      yield* _mapEnteredSecondTimeEventToState(event);
    } else if (event is EnteredWrongPinEvent) {
      yield* _mapPinCodeInitErrorEventToState(event);
    } else if (event is SkippedPinInitializationEvent) {
      yield* _mapSkippedPinInitializationEventToState(event);
    }
  }

  Stream<PinCodeInitState> _mapEnteredFirstTimeEventToState(EnteredFirstTimeEvent event) async* {
    yield EnterPinSecondTimeState();
    pin = pinEnter;
    dots = [false, false, false, false];
    dotNum = 0;
    pinEnter = [null, null, null, null];
  }

  Stream<PinCodeInitState> _mapEnteredSecondTimeEventToState(EnteredSecondTimeEvent event) async* {
    dotNum = 0;
    dots = [false, false, false, false];
    if (event.pinEnter[0] == pin[0] && event.pinEnter[1] == pin[1] && event.pinEnter[2] == pin[2] && event.pinEnter[3] == pin[3]) {
      yield InitialPinCodeInitState();
      pinFlag = true;
      pinEnter = [null, null, null, null];
      navigationManager.pushRouteWithReplacement(Routes.ENTER_ID);
    } else {
      yield PinCodeInitErrorState();
    }
  }

  Stream<PinCodeInitState> _mapPinCodeInitErrorEventToState(EnteredWrongPinEvent event) async* {
    pinFlag = false;
    dots = [false, false, false, false];
    pinEnter = [null, null, null, null];
    dotNum = 0;
    yield InitialPinCodeInitState();
  }

  Stream<PinCodeInitState> _mapSkippedPinInitializationEventToState(SkippedPinInitializationEvent event) async* {
    if (event.isSkipped){
      yield InitialPinCodeInitState();
      navigationManager.pushRouteWithReplacement(Routes.ENTER_ID);
      dotNum = 0;
      dots = [false, false, false, false];
      pinEnter = [null, null, null, null];
      pin = [null, null, null, null];
      pinFlag = false;
    }
  }
}