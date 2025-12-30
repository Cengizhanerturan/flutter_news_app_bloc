import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/constants/app_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: AppColorsDark.primary,
  scaffoldBackgroundColor: AppColorsDark.background,
  cardColor: AppColorsDark.cardBackground,
  canvasColor: AppColorsDark.darkGrey,
  unselectedWidgetColor: AppColorsDark.grey,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hintColor: AppColorsDark.hint,
  dividerColor: AppColorsDark.border,
  iconTheme: IconThemeData(size: 16.px, color: AppColorsDark.white),
  primaryIconTheme: IconThemeData(size: 16.px, color: AppColorsDark.primary),
  switchTheme: SwitchThemeData(
    trackOutlineWidth: WidgetStateProperty.all(2.px),
    trackOutlineColor: WidgetStateProperty.all(AppColorsDark.border),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColorsDark.background,
    selectedItemColor: AppColorsDark.primary,
    showSelectedLabels: true,
    unselectedItemColor: AppColorsDark.textSecondary,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.primary,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColorsDark.primary,
    selectionHandleColor: AppColorsDark.primary,
  ),
  primaryTextTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 22.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textPrimary,
    ),
    titleMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 20.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textPrimary,
    ),
    titleSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.5.sp,
      letterSpacing: 0.75,
      color: AppColorsDark.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
    bodySmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
    labelLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
    labelMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 14.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
    labelSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 13.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textPrimary,
    ),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textSecondary,
    ),
    titleLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 22.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textSecondary,
    ),
    titleMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 20.0.sp,
      letterSpacing: 0.25,
      color: AppColorsDark.textSecondary,
    ),
    titleSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.5.sp,
      letterSpacing: 0.75,
      color: AppColorsDark.textSecondary,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
    bodySmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
    labelLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
    labelMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 14.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
    labelSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 13.0.sp,
      letterSpacing: 0.5,
      color: AppColorsDark.textSecondary,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(error: AppColorsDark.red)
      .copyWith(brightness: Brightness.dark)
      .copyWith(surface: AppColorsDark.background),
);

final ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: AppColorsLight.primary,
  scaffoldBackgroundColor: AppColorsLight.background,
  cardColor: AppColorsLight.cardBackground,
  canvasColor: AppColorsLight.darkGrey,
  unselectedWidgetColor: AppColorsLight.grey,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hintColor: AppColorsLight.hint,
  dividerColor: AppColorsLight.border,
  iconTheme: IconThemeData(size: 16.px, color: AppColorsLight.lightBlack),
  primaryIconTheme: IconThemeData(size: 16.px, color: AppColorsLight.primary),
  switchTheme: SwitchThemeData(
    trackOutlineWidth: WidgetStateProperty.all(2.px),
    trackOutlineColor: WidgetStateProperty.all(AppColorsLight.border),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor: AppColorsLight.primary,
    showSelectedLabels: true,
    unselectedItemColor: AppColorsLight.textSecondary,
    showUnselectedLabels: true,
    selectedLabelStyle: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.primary,
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
      fontWeight: FontWeight.w400,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColorsLight.primary,
    selectionHandleColor: AppColorsLight.primary,
  ),
  primaryTextTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textPrimary,
    ),
    titleLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 22.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textPrimary,
    ),
    titleMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 20.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textPrimary,
    ),
    titleSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.5.sp,
      letterSpacing: 0.75,
      color: AppColorsLight.textPrimary,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
    bodySmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
    labelLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
    labelMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 14.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
    labelSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 13.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textPrimary,
    ),
  ),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 19.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textSecondary,
    ),
    titleLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 22.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textSecondary,
    ),
    titleMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 20.0.sp,
      letterSpacing: 0.25,
      color: AppColorsLight.textSecondary,
    ),
    titleSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.5.sp,
      letterSpacing: 0.75,
      color: AppColorsLight.textSecondary,
    ),
    bodyLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 17.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
    bodyMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 16.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
    bodySmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
    labelLarge: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 15.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
    labelMedium: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 14.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
    labelSmall: TextStyle(
      fontFamily: AppConstants.textFontFamily,
      fontSize: 13.0.sp,
      letterSpacing: 0.5,
      color: AppColorsLight.textSecondary,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(error: AppColorsLight.red)
      .copyWith(brightness: Brightness.light)
      .copyWith(surface: AppColorsLight.background),
);
