import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/theme/theme_bloc.dart';
import 'package:zimsmobileapp/presentation/styles.dart';

mixin ThemeProviderMixin {
  ThemeData getAppThemeData(BuildContext context) =>
      appThemeData[BlocProvider.of<ThemeBloc>(context).state.appTheme];

  Color getColor(BuildContext context, CustomColors key) {
    final theme = BlocProvider.of<ThemeBloc>(context).state.appTheme;
    return ColorsProvider.getColor(theme, key);
  }

  Color hexToColor(String code) {
    try {
      return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    } catch (e) {
      return Colors.black;
    }
  }
}
