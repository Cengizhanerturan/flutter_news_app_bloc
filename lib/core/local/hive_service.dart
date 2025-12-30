import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();

    // News Box
    if (!Hive.isBoxOpen('news_box')) {
      await Hive.openBox('news_box');
    }

    // Theme Box
    if (!Hive.isBoxOpen('theme_box')) {
      await Hive.openBox('theme_box');
    }
  }

  Box get newsBox => Hive.box('news_box');
  Box get themeBox => Hive.box('theme_box');
}
