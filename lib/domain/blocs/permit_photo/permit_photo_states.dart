import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class PermitPhotoState extends Equatable {}

class PermitPhotoEmpty extends PermitPhotoState {
  @override
  List<Object> get props => [];
}

class PermitPhotoLoading extends PermitPhotoState {
  @override
  List<Object> get props => [];
}

class PermitPhotoLoaded extends PermitPhotoState {
  final PermitPhoto permitPhoto;

  PermitPhotoLoaded({@required this.permitPhoto});

  @override
  List<Object> get props => [permitPhoto];
}

class PermitPhotoError extends PermitPhotoState {
  final Exception exception;

  PermitPhotoError({@required this.exception});

  @override
  List<Object> get props => [exception];
}

class PermitPhotoNotFound extends PermitPhotoState {
  @override
  List<Object> get props => [];
}
