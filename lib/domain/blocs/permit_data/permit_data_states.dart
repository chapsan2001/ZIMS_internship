import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/domain/models/models.dart';

abstract class PermitDataState extends Equatable {}

class PermitDataEmpty extends PermitDataState {
  @override
  List<Object> get props => [];
}

class PermitDataLoading extends PermitDataState {
  @override
  List<Object> get props => [];
}

class PermitDataLoaded extends PermitDataState {
  final PermitData permitData;

  PermitDataLoaded({@required this.permitData});

  @override
  List<Object> get props => [permitData];
}

class PermitDataError extends PermitDataState {
  final Exception exception;

  PermitDataError({@required this.exception});

  @override
  List<Object> get props => [exception];
}

class PermitDataNotFound extends PermitDataState {
  @override
  List<Object> get props => [];
}
