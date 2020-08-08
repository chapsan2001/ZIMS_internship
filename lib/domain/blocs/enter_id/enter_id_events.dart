import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class EnterIdEvent extends Equatable {}

// Enter id events
class GetDocumentTypeEvent extends EnterIdEvent {
  final DocumentType currentDocumentType;

  GetDocumentTypeEvent({@required this.currentDocumentType});

  @override
  List<Object> get props => [currentDocumentType];
}

class FindDocumentPressedEvent extends EnterIdEvent {
  final DocumentInfo documentInfo;

  FindDocumentPressedEvent({@required this.documentInfo});

  @override
  List<Object> get props => [documentInfo];
}

// QR events
class ScanQrPressedEvent extends EnterIdEvent {
  @override
  List<Object> get props => [];
}

class ConfirmLockEvent extends EnterIdEvent {
  final bool isLocked;
  ConfirmLockEvent({this.isLocked});
  @override
  List<Object> get props => [isLocked];
}

// Logout events
class ConfirmLogoutEvent extends EnterIdEvent {
  final bool isLogout;

  ConfirmLogoutEvent({this.isLogout = false});

  @override
  List<Object> get props => [isLogout];
}

// History event
class HistoryOpenEvent extends EnterIdEvent {
  @override
  List<Object> get props => [];
}