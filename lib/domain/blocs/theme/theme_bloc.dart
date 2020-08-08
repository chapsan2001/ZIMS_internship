import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimsmobileapp/domain/blocs/theme/app_themes.dart';

abstract class ThemeEvent extends Equatable {}

class ChangeThemeEvent extends ThemeEvent {
  final AppTheme theme;

  ChangeThemeEvent({@required this.theme});

  @override
  List<Object> get props => [theme];
}

abstract class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({@required this.appTheme});
}

class OnThemeSelected extends ThemeState {
  OnThemeSelected({@required AppTheme appTheme}) : super(appTheme: appTheme);

  @override
  List<Object> get props => [appTheme];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => OnThemeSelected(appTheme: AppTheme.MainTheme);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ChangeThemeEvent) {
      yield OnThemeSelected(appTheme: event.theme);
    }
  }
}
