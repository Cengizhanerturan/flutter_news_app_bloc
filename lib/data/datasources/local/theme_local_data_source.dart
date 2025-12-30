import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeLocalDataSource {
  final Box _box;

  ThemeLocalDataSource(this._box);

  ThemeMode getTheme() {
    var isDarkMode = _box.get(CacheConstants.keyIsDarkMode);
    if (isDarkMode == null) {
      return ThemeMode.light;
    } else {
      return isDarkMode ? ThemeMode.dark : ThemeMode.light;
    }
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    await _box.put(CacheConstants.keyIsDarkMode, themeMode == ThemeMode.dark);
  }
}
