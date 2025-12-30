import 'package:flutter_news_app/core/constants/asset_constants.dart';

class AppConstants {
  static const String appName = 'Flutter News';
  static const String textFontFamily = 'Montserrat';

  static const List<String> bottomNavIcons = [
    AssetConstants.home,
    AssetConstants.discover,
    AssetConstants.saved,
    AssetConstants.settings,
  ];

  static const List<String> bottomNavActiveIcons = [
    AssetConstants.homeActive,
    AssetConstants.discoverActive,
    AssetConstants.savedActive,
    AssetConstants.settingsActive,
  ];

  static const List<String> bottomNavLabels = [
    'Home',
    'Discover',
    'Saved',
    'Settings',
  ];
}
