import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:zimsmobileapp/app_state_observer.dart';
import 'package:zimsmobileapp/data/api/custom_http_overrides.dart';
import 'package:zimsmobileapp/data/translations/global_translations.dart';
import 'package:zimsmobileapp/di/locator.dart';
import 'package:zimsmobileapp/domain/blocs/blocs.dart';
import 'package:zimsmobileapp/domain/navigation/routes.dart';
import 'package:zimsmobileapp/domain/translations/translations_hander.dart';
import 'package:zimsmobileapp/presentation/navigation/router.dart';
import 'package:zimsmobileapp/presentation/styles.dart';
import 'package:zimsmobileapp/domain/models/permit_data.dart';

List<int> pinEnter = [null, null, null, null];
List<int> pin = [null, null, null, null];
bool pinFlag = false;
List<bool> dots = [false, false, false, false];
int dotNum = 0;
int attempts = 3;
String userName;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = CustomHttpOverrides();

  await initLocator();
  await initTranslations();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(PermitDataAdapter());
  final key = [167, 14, 67, 86, 164, 221, 192, 62, 237, 196, 93, 190, 128, 219, 77, 131, 169, 103, 183, 240, 212, 157, 127, 106, 11, 55, 218, 44, 140, 9, 227, 225];
  Hive.openBox('history', encryptionKey: key);
  runApp(App());
}

Future<Null> initTranslations() async {
  final TranslationsHandler handler = locator();
  await handler.init();
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => locator(),
        ),
        BlocProvider<TranslationsBloc>(
          create: (context) => locator(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<TranslationsBloc, TranslationsState>(
            builder: (context, translationsState) {
              return AppStateObserver(
                appPauseManager: locator(),
                app: MaterialApp(
                  title: allTranslations.text('app.name'),
                  theme: appThemeData[themeState.appTheme],
                  navigatorKey: locator(),
                  initialRoute: Routes.LOGIN,
                  onGenerateRoute: router.onGenerateRoute,
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: allTranslations.supportedLocales(),
                  locale: translationsState.locale,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
