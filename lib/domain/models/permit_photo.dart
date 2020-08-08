import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PermitPhoto extends Equatable {
  final Uint8List bytes;

  PermitPhoto({@required this.bytes});

  @override
  List<Object> get props => [bytes];
}
