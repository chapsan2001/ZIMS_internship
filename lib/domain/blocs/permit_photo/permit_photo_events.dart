import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class PermitPhotoEvent extends Equatable {}

class FetchPermitPhotoEvent extends PermitPhotoEvent {
  final DocumentInfo documentInfo;

  FetchPermitPhotoEvent({@required this.documentInfo});

  @override
  List<Object> get props => [documentInfo];
}
