import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:zimsmobileapp/domain/models/document_info.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
}

class ConfirmHistoryClearEvent extends HistoryEvent {
  final bool isCleared;

  ConfirmHistoryClearEvent({this.isCleared = false});

  @override
  List<Object> get props => [isCleared];
}

class TapOnDocEvent extends HistoryEvent {
  final DocumentInfo documentInfo;
  const TapOnDocEvent({@required this.documentInfo});
  @override
  List<Object> get props => [documentInfo];
}