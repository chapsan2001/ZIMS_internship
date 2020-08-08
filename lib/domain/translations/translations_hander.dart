import 'dart:ui';

abstract class TranslationsHandler {
  Locale get locale;

  Future<Null> init();

  Future<Null> setNewLanguage(String newLanguage);
}
