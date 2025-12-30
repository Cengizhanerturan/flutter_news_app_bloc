import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/widget/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final void Function()? primaryButtonOnTap;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final void Function()? secondaryButtonOnTap;
  const CustomDialog({
    super.key,
    required this.message,
    this.primaryButtonOnTap,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.secondaryButtonOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.px)),
      child: Container(
        padding: AppPadding.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.px),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: Theme.of(context).primaryTextTheme.bodyMedium?.medium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (secondaryButtonText != null)
                  CustomButton(
                    buttonText: secondaryButtonText!,
                    isFullWidth: false,
                    color: Theme.of(context).colorScheme.error,
                    onTap: () {
                      if (secondaryButtonOnTap != null) {
                        secondaryButtonOnTap!();
                      } else {
                        context.back();
                      }
                    },
                  ),
                if (secondaryButtonText != null) SizedBox(width: 8.px),
                CustomButton(
                  buttonText: primaryButtonText ?? 'Ok',
                  isFullWidth: false,
                  onTap: () {
                    if (primaryButtonOnTap != null) {
                      primaryButtonOnTap!();
                    } else {
                      context.back();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
