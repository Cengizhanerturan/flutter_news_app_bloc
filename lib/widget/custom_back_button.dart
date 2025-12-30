import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBackButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  const CustomBackButton({super.key, this.padding, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          context.back();
        }
      },
      child: Container(
        padding: AppPadding.all(AppSpacing.sm),
        margin: padding ?? AppPadding.horizontal(AppSpacing.md),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: Icon(Icons.arrow_back_ios_rounded, size: 20.px),
      ),
    );
  }
}
