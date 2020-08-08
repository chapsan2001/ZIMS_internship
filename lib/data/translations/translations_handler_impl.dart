import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/domain/translations/translations_hander.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';

class TranslationsHandlerImpl implements TranslationsHandler {
  final AppPreferences appPreferences;

  TranslationsHandlerImpl({@required this.appPreferences});

  @override
  Locale get locale => allTranslations.locale;

  @override
  Future<Null> init() async {
    return appPreferences
        .getLanguage()
        .then((language) => allTranslations.init(language));
  }

  @override
  Future<Null> setNewLanguage(String newLanguage) async {
    return appPreferences
        .putLanguage(newLanguage)
        .then((isSuccess) => allTranslations.setNewLanguage(newLanguage));
  }
}
