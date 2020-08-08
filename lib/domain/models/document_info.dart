import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

class DocumentInfo extends Equatable {
  final String documentNumber;
  final DocumentType documentType;

  DocumentInfo({@required this.documentNumber, @required this.documentType});

  @override
  List<Object> get props => [documentNumber, documentType];
}
