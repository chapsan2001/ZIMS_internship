import 'package:equatable/equatable.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
}

class InitialHistoryState extends HistoryState with EquatableMixin{
  InitialHistoryState();
  @override
  List<Object> get props => [];
}