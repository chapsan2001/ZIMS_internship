import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/translations/translations_hander.dart';

class TranslationsEvent extends Equatable {
  final String language;

  TranslationsEvent({@required this.language});

  @override
  List<Object> get props => [language];
}

class TranslationsState extends Equatable {
  final Locale locale;

  TranslationsState({@required this.locale});

  @override
  List<Object> get props => [locale];
}

class TranslationsBloc extends Bloc<TranslationsEvent, TranslationsState> {
  final TranslationsHandler translationsHandler;

  TranslationsBloc({@required this.translationsHandler});

  @override
  TranslationsState get initialState =>
      TranslationsState(locale: translationsHandler.locale);

  @override
  Stream<TranslationsState> mapEventToState(TranslationsEvent event) async* {
    await translationsHandler.setNewLanguage(event.language);
    yield TranslationsState(locale: Locale(event.language, ""));
  }
}
