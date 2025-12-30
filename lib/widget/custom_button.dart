import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function() onTap;
  final bool isLoading;
  final bool isEnabled;
  final bool isFullWidth;
  final Color? color;
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.all(AppSpacing.md),
      child: InkWell(
        onTap: isEnabled && !isLoading ? onTap : null,
        child: Container(
          height: 55.px,
          width: isFullWidth ? Device.width : 100.px,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.px),
            color: _getButtonColor(context),
          ),
          child: _buildButtonContent(context),
        ),
      ),
    );
  }

  Color _getButtonColor(BuildContext context) {
    if (isLoading || !isEnabled) {
      return Theme.of(context).disabledColor;
    }
    if (color != null) {
      return color!;
    }
    return Theme.of(context).primaryColor;
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return Lottie.asset(AssetConstants.loading, height: 50.px);
    } else {
      return Center(
        child: AutoSizeText(
          buttonText,
          style: Theme.of(context).primaryTextTheme.bodyMedium?.medium.copyWith(
            color: AppColorsLight.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      );
    }
  }
}
