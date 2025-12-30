import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:flutter_news_app/data/datasources/local/theme_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_box.dart';

void main() {
  late Box box;
  late ThemeLocalDataSource themeLocalDataSource;

  setUp(() {
    box = MockBox();
    themeLocalDataSource = ThemeLocalDataSource(box);
  });

  test(
    'getTheme | lokalden null geldiginde light döner -> ThemeMode.light',
    () {
      when(() => box.get(CacheConstants.keyIsDarkMode)).thenReturn(null);
      final result = themeLocalDataSource.getTheme();
      expect(result, ThemeMode.light);
    },
  );

  test(
    'getTheme | lokalden false geldiginde light döner -> ThemeMode.light',
    () {
      when(() => box.get(CacheConstants.keyIsDarkMode)).thenReturn(false);
      final result = themeLocalDataSource.getTheme();
      expect(result, ThemeMode.light);
    },
  );

  test('getTheme | lokalden true geldiginde dark döner -> ThemeMode.dark', () {
    when(() => box.get(CacheConstants.keyIsDarkMode)).thenReturn(true);
    final result = themeLocalDataSource.getTheme();
    expect(result, ThemeMode.dark);
  });

  test(
    'setTheme | Theme mode light olarak verildiginde lokale false kaydedilir',
    () async {
      when(
        () => box.put(CacheConstants.keyIsDarkMode, any()),
      ).thenAnswer((_) async => {});

      await themeLocalDataSource.setTheme(ThemeMode.light);

      verify(() => box.put(CacheConstants.keyIsDarkMode, false)).called(1);
    },
  );

  test(
    'setTheme | Theme mode dark olarak verildiginde lokale true kaydedilir',
    () async {
      when(
        () => box.put(CacheConstants.keyIsDarkMode, any()),
      ).thenAnswer((_) async => {});

      await themeLocalDataSource.setTheme(ThemeMode.dark);

      verify(() => box.put(CacheConstants.keyIsDarkMode, true)).called(1);
    },
  );
}
