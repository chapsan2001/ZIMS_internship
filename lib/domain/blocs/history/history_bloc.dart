import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:zimsmobileapp/domain/blocs/history/history_events.dart';
import 'package:zimsmobileapp/domain/blocs/history/history_states.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final NavigationManager navigationManager;

  HistoryBloc({@required this.navigationManager});

  @override
  HistoryState get initialState => InitialHistoryState();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is TapOnDocEvent) {
      yield* _mapTapOnDocEventToState(event);
    } else if (event is ConfirmHistoryClearEvent) {
      yield* _mapConfirmHistoryClearEventToState(event);
    }
  }

  Stream<HistoryState> _mapTapOnDocEventToState(
      TapOnDocEvent event) async* {
    navigationManager.pushRoute(Routes.PERMIT_DATA, event.documentInfo);
  }

  Stream<HistoryState> _mapConfirmHistoryClearEventToState(
      ConfirmHistoryClearEvent event) async* {
    if (event.isCleared) {
      Hive.box('history').clear();
      navigationManager.goBack();
    }
  }
}
