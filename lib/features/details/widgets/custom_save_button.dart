import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSaveButton extends StatelessWidget {
  final bool isSaved;
  final void Function() onTap;
  const CustomSaveButton({
    super.key,
    required this.isSaved,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: AppPadding.all(AppSpacing.sm),
        margin: AppPadding.horizontal(AppSpacing.md),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: ImageIcon(
          AssetImage(
            isSaved ? AssetConstants.savedActive : AssetConstants.saved,
          ),
          size: 20.px,
        ),
      ),
    );
  }
}
