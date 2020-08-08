import 'package:flutter/material.dart';
import 'package:zimsmobileapp/domain/blocs/theme/app_themes.dart';

final appThemeData = {
  AppTheme.MainTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: mainThemeMaterialColor,
    accentColor: mainThemeMaterialColor,
    errorColor: Color.fromARGB(255, 198, 40, 40),
  ),
};

Map<int, Color> mainThemeColor = {
  50: Color.fromRGBO(98, 137, 61, .1),
  100: Color.fromRGBO(98, 137, 61, .2),
  200: Color.fromRGBO(98, 137, 61, .3),
  300: Color.fromRGBO(98, 137, 61, .4),
  400: Color.fromRGBO(98, 137, 61, .5),
  500: Color.fromRGBO(98, 137, 61, .6),
  600: Color.fromRGBO(98, 137, 61, .7),
  700: Color.fromRGBO(98, 137, 61, .8),
  800: Color.fromRGBO(98, 137, 61, .9),
  900: Color.fromRGBO(98, 137, 61, 1),
};

MaterialColor mainThemeMaterialColor =
    MaterialColor(0xFF62893D, mainThemeColor);

enum CustomColors {
  FILL_COLOR,
  HINT_COLOR,
  DARK_GRAY_COLOR,
  GRAY_BACKGROUND_COLOR,
  GRAY_LIGHT_COLOR,
  DIVIDER_COLOR
}

class ColorsProvider {
  static Map<CustomColors, Color> mainThemeColors = {
    CustomColors.FILL_COLOR: Color.fromARGB(30, 118, 118, 128),
    CustomColors.HINT_COLOR: Color.fromARGB(153, 60, 60, 67),
    CustomColors.DARK_GRAY_COLOR: Color.fromARGB(255, 102, 102, 102),
    CustomColors.GRAY_BACKGROUND_COLOR: Color.fromARGB(255, 249, 249, 249),
    CustomColors.GRAY_LIGHT_COLOR: Color.fromARGB(255, 189, 189, 189),
    CustomColors.DIVIDER_COLOR: Color.fromARGB(255, 229, 229, 234),
  };

  static Color getColor(AppTheme appTheme, CustomColors key) {
    switch (appTheme) {
      case AppTheme.MainTheme:
        return mainThemeColors[key];
        break;
      default:
        throw UnimplementedError("Implement your custom theme!");
        break;
    }
  }
}
