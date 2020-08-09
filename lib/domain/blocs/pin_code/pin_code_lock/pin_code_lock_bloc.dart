import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_lock/pin_code_lock_events.dart';
import 'package:zimsmobileapp/domain/blocs/pin_code/pin_code_lock/pin_code_lock_states.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/main.dart';

class PinCodeLockBloc extends Bloc<PinCodeLockEvent, PinCodeLockState> {
  final NavigationManager navigationManager;

  PinCodeLockBloc({@required this.navigationManager});

  @override
  PinCodeLockState get initialState => InitialPinCodeLockState();

  @override
  Stream<PinCodeLockState> mapEventToState(PinCodeLockEvent event) async* {
    if (event is EnteredWrongPinEvent) {
      yield* _mapEnteredWrongPinToState(event);
    } else if (event is LoggedOutEvent) {
      yield* _mapLoggedOutToState(event);
    } else if (event is UnlockedEvent) {
      yield* _mapUnlockedToState(event);
    }
  }

  Stream<PinCodeLockState> _mapEnteredWrongPinToState(EnteredWrongPinEvent event) async* {
    attempts--;
    if (attempts == 0) {
      attempts = 3;
      pinFlag = false;
      pin = [null, null, null, null];
      pinEnter = [null, null, null, null];
      dots = [false, false, false, false];
      dotNum = 0;
      userName = null;
      navigationManager.pushRouteWithReplacement(Routes.LOGIN);
    }
    yield PinCodeLockErrorState();
    yield InitialPinCodeLockState();
  }

  Stream<PinCodeLockState> _mapLoggedOutToState(LoggedOutEvent event) async* {
    if (event.isLogout) {
      yield InitialPinCodeLockState();
      attempts = 3;
      pinFlag = false;
      pin = [null, null, null, null];
      pinEnter = [null, null, null, null];
      dots = [false, false, false, false];
      dotNum = 0;
      userName = null;
      navigationManager.pushRouteWithReplacement(Routes.LOGIN);
    }
  }

  Stream<PinCodeLockState> _mapUnlockedToState(UnlockedEvent event) async* {
    yield InitialPinCodeLockState();
    attempts = 3;
    pinEnter = [null, null, null, null];
    dots = [false, false, false, false];
    dotNum = 0;
    navigationManager.pushRouteWithReplacement(Routes.ENTER_ID);
  }
}