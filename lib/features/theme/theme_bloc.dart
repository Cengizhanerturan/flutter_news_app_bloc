import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/datasources/local/theme_local_data_source.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeLocalDataSource _themeLocalDataSource;

  ThemeBloc(this._themeLocalDataSource) : super(ThemeState(ThemeMode.light)) {
    on<ThemeLoadRequested>(_onThemeLoadRequested);
    on<ThemeToggled>(_onThemeToggled);
  }

  void _onThemeLoadRequested(
    ThemeLoadRequested event,
    Emitter<ThemeState> emit,
  ) {
    final themeMode = _themeLocalDataSource.getTheme();
    _setSystemUIOverlayStyle(themeMode);
    emit(ThemeState(themeMode));
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final themeMode = state.isDark ? ThemeMode.light : ThemeMode.dark;
    await _themeLocalDataSource.setTheme(themeMode);
    _setSystemUIOverlayStyle(themeMode);
    emit(ThemeState(themeMode));
  }

  void _setSystemUIOverlayStyle(ThemeMode theme) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness:
            theme == ThemeMode.light ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            theme == ThemeMode.light ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
