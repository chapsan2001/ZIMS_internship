import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;

  User({this.firstName, this.lastName});

  @override
  List<Object> get props => [firstName, lastName];
}
