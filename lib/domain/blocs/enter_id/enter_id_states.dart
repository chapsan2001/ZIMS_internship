import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class EnterIdState {}

class InitialEnterIdState extends EnterIdState with EquatableMixin {
  @override
  List<Object> get props => [];
}

// Enter id states
class ReceivedDocumentTypeState extends EnterIdState with EquatableMixin {
  final DocumentType documentType;

  ReceivedDocumentTypeState({@required this.documentType});

  @override
  List<Object> get props => [documentType];
}

// QR states
class QrScanErrorState extends EnterIdState {}
