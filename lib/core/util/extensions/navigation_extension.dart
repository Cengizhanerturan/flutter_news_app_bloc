import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_news_app/core/router/app_routes.dart';
import 'package:flutter_news_app/data/models/news_model.dart';

extension NavigationExtension on BuildContext {
  void toHome({bool replaceAll = false}) {
    if (replaceAll) {
      goNamed(AppRoutes.HOME);
    } else {
      pushNamed(AppRoutes.HOME);
    }
  }

  void toDiscover() => goNamed(AppRoutes.DISCOVER);

  void toSaved() => goNamed(AppRoutes.SAVED);

  void toSetting() => goNamed(AppRoutes.SETTING);

  void toAuth({bool replaceAll = false}) {
    if (replaceAll) {
      goNamed(AppRoutes.AUTH);
    } else {
      pushNamed(AppRoutes.AUTH);
    }
  }

  void toSearch() => pushNamed(AppRoutes.SEARCH);

  Future<T?> toDetails<T>({
    required NewsModel news,
    bool isFromSaved = false,
  }) async {
    return await pushNamed<T>(
      AppRoutes.DETAILS,
      extra: news,
      queryParameters: {'saved': isFromSaved.toString()},
    );
  }

  void toVerifyMail({bool isFromAuthPage = true, String? newEmail}) {
    if (!isFromAuthPage) {
      goNamed(
        AppRoutes.VERIFY_MAIL,
        queryParameters: {
          'fromAuth': isFromAuthPage.toString(),
          if (newEmail != null) 'newEmail': newEmail,
        },
      );
    } else {
      pushNamed(
        AppRoutes.VERIFY_MAIL,
        queryParameters: {
          'fromAuth': isFromAuthPage.toString(),
          if (newEmail != null) 'newEmail': newEmail,
        },
      );
    }
  }

  void toUpdateUserInformation() =>
      pushNamed(AppRoutes.UPDATE_USER_INFORMATION);

  void toUpdateMail() => pushNamed(AppRoutes.UPDATE_MAIL);

  void toUpdatePassword() => pushNamed(AppRoutes.UPDATE_PASSWORD);

  void toWebView(String url) {
    pushNamed(AppRoutes.WEBVIEW, extra: url);
  }

  void back<T extends Object?>([T? result]) => pop(result);
}
