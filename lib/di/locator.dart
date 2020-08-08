import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:zimsmobileapp/data/api/zims_api.dart';
import 'package:zimsmobileapp/data/api/zims_client.dart';
import 'package:zimsmobileapp/data/services/auth_service.dart';
import 'package:zimsmobileapp/data/services/permit_service.dart';
import 'package:zimsmobileapp/data/services/qr_scan_service.dart';
import 'package:zimsmobileapp/data/translations/translations_handler_impl.dart';
import 'package:zimsmobileapp/data/utils/app_pause_manager_impl.dart';
import 'package:zimsmobileapp/data/utils/app_preferences_provider.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/navigation/navigation_manager.dart';
import 'package:zimsmobileapp/domain/repositories/auth_repository.dart';
import 'package:zimsmobileapp/domain/repositories/permit_repository.dart';
import 'package:zimsmobileapp/domain/repositories/qr_scan_repository.dart';
import 'package:zimsmobileapp/domain/translations/translations_hander.dart';
import 'package:zimsmobileapp/domain/utils/app_pause_manager.dart';
import 'package:zimsmobileapp/domain/utils/app_preferences.dart';
import 'package:zimsmobileapp/presentation/navigation/navigation_manager_impl.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  _initNavigation();
  _initUtils();
  _initTranslations();
  _initNetwork();
  _initRepositories();
  _initBlocs();
}

void _initNavigation() {
  locator.registerLazySingleton<GlobalKey<NavigatorState>>(
      () => GlobalKey<NavigatorState>());

  locator.registerLazySingleton<NavigationManager>(
      () => NavigationManagerImpl(navigatorKey: locator()));
}

void _initUtils() {
  locator.registerLazySingleton<AppPreferences>(() => AppPreferencesProvider());
}

void _initTranslations() {
  locator.registerLazySingleton<TranslationsHandler>(
      () => TranslationsHandlerImpl(appPreferences: locator()));
  locator.registerLazySingleton<AppPauseManager>(() => AppPauseManagerImpl(
      appPreferences: locator(), navigationManager: locator()));
}

void _initNetwork() {
  locator.registerLazySingleton<http.Client>(() => http.Client());
  locator
      .registerLazySingleton<ZimsApi>(() => ZimsClient(httpClient: locator()));
}

void _initRepositories() {
  locator.registerLazySingleton<AuthRepository>(
      () => AuthService(appPreferences: locator(), api: locator()));

  locator.registerLazySingleton<QrScanRepository>(() => QrScanService());

  locator.registerLazySingleton<PermitRepository>(
      () => PermitService(appPreferences: locator(), api: locator()));
}

void _initBlocs() {
  locator.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  locator.registerLazySingleton<TranslationsBloc>(
      () => TranslationsBloc(translationsHandler: locator()));

  locator.registerFactory<LoginBloc>(
      () => LoginBloc(authRepository: locator(), navigationManager: locator()));

  locator.registerFactory<EnterIdBloc>(() =>
      EnterIdBloc(qrScanRepository: locator(), navigationManager: locator()));

  locator.registerFactory<PermitDataBloc>(() => PermitDataBloc(
      permitRepository: locator(), navigationManager: locator()));

  locator.registerFactory<PermitPhotoBloc>(() => PermitPhotoBloc(
      permitRepository: locator(), navigationManager: locator()));

  locator.registerFactory<HistoryBloc>(
      () => HistoryBloc(navigationManager: locator()));

  locator.registerFactory<PinCodeInitBloc>(
      () => PinCodeInitBloc(navigationManager: locator()));

  locator.registerFactory<PinCodeLockBloc>(
      () => PinCodeLockBloc(navigationManager: locator()));
}
