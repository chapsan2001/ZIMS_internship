import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class PermitDataEvent extends Equatable {}

class FetchPermitDataEvent extends PermitDataEvent {
  final DocumentInfo documentInfo;

  FetchPermitDataEvent({@required this.documentInfo});

  @override
  List<Object> get props => [documentInfo];
}

class OpenPhotoEvent extends PermitDataEvent {
  final DocumentInfo documentInfo;

  OpenPhotoEvent({@required this.documentInfo});

  @override
  List<Object> get props => [documentInfo];
}
