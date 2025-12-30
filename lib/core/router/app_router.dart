import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/router/app_routes.dart';
import 'package:flutter_news_app/core/router/bottom_nav_shell.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/features/auth/pages/verify_mail/view/verify_mail_page.dart';
import 'package:flutter_news_app/features/auth/view/auth_page.dart';
import 'package:flutter_news_app/features/details/view/details_page.dart';
import 'package:flutter_news_app/features/discover/view/discover_page.dart';
import 'package:flutter_news_app/features/home/view/home_page.dart';
import 'package:flutter_news_app/features/saved/view/saved_page.dart';
import 'package:flutter_news_app/features/search/view/search_page.dart';
import 'package:flutter_news_app/features/setting/pages/update_mail/view/update_mail_page.dart';
import 'package:flutter_news_app/features/setting/pages/update_password/view/update_password_page.dart';
import 'package:flutter_news_app/features/setting/pages/update_user_information/view/update_user_information_page.dart';
import 'package:flutter_news_app/features/setting/view/setting_page.dart';
import 'package:flutter_news_app/features/splash/view/splash_page.dart';
import 'package:flutter_news_app/features/webview/view/webview_page.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.SPLASH,
  routes: [
    _buildMainShell(),
    GoRoute(
      path: AppRoutes.SPLASH,
      name: AppRoutes.SPLASH,
      builder: (context, state) => SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.AUTH,
      name: AppRoutes.AUTH,
      builder: (context, state) => AuthPage(),
    ),
    GoRoute(
      path: AppRoutes.SEARCH,
      name: AppRoutes.SEARCH,
      builder: (context, state) => SearchPage(),
    ),
    GoRoute(
      path: AppRoutes.DETAILS,
      name: AppRoutes.DETAILS,
      builder: (context, state) {
        final news = state.extra as NewsModel?;
        final isFromSaved = state.uri.queryParameters['saved'] == 'true';

        return DetailsPage(newsModel: news, isFromSavedPage: isFromSaved);
      },
    ),
    GoRoute(
      path: AppRoutes.VERIFY_MAIL,
      name: AppRoutes.VERIFY_MAIL,
      builder: (context, state) {
        final isFromAuthPage = state.uri.queryParameters['fromAuth'] == 'true';
        final newEmail = state.uri.queryParameters['newEmail'];
        return VerifyMailPage(
          isFromAuthPage: isFromAuthPage,
          newEmail: newEmail,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.UPDATE_USER_INFORMATION,
      name: AppRoutes.UPDATE_USER_INFORMATION,
      builder: (context, state) => UpdateUserInformationPage(),
    ),
    GoRoute(
      path: AppRoutes.UPDATE_MAIL,
      name: AppRoutes.UPDATE_MAIL,
      builder: (context, state) => UpdateMailPage(),
    ),
    GoRoute(
      path: AppRoutes.UPDATE_PASSWORD,
      name: AppRoutes.UPDATE_PASSWORD,
      builder: (context, state) => UpdatePasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.WEBVIEW,
      name: AppRoutes.WEBVIEW,
      builder: (context, state) {
        final url = state.extra as String;
        return WebviewPage(url: url);
      },
    ),
  ],
);

StatefulShellRoute _buildMainShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return BottomNavShell(shell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.HOME,
            name: AppRoutes.HOME,
            builder: (_, __) => const HomePage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.DISCOVER,
            name: AppRoutes.DISCOVER,
            builder: (_, __) => const DiscoverPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.SAVED,
            name: AppRoutes.SAVED,
            builder: (_, __) => const SavedPage(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.SETTING,
            name: AppRoutes.SETTING,
            builder: (_, __) => const SettingPage(),
          ),
        ],
      ),
    ],
  );
}
