import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? error;
  final String? buttonText;
  final Function? onRetry;
  const CustomErrorWidget({
    super.key,
    this.error,
    this.buttonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Device.width,
      height: Device.height * 0.4,
      padding: AppPadding.horizontal(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            error ?? StringConstants.DEFAULT_ERROR_MESSAGE,
            style: Theme.of(context).primaryTextTheme.bodyMedium?.medium,
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: () {
              if (onRetry != null) {
                onRetry!();
              }
            },
            child: Container(
              margin: AppPadding.only(top: AppSpacing.xlg),
              padding: AppPadding.symmetric(
                vertical: AppSpacing.sm,
                horizontal: AppSpacing.xlg,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.px),
                color: Theme.of(context).primaryColor,
              ),
              child: Text(
                buttonText ?? StringConstants.RETRY_BUTTON_DEFAULT_TEXT,
                style: Theme.of(context).primaryTextTheme.bodyMedium?.medium
                    .copyWith(color: AppColorsLight.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
