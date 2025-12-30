import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSwitch;
  final bool? switchValue;
  final Function(bool)? switchOnChanged;
  final Function()? onTap;
  final IconData? icon;
  const SettingCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isSwitch = false,
    this.switchValue,
    this.switchOnChanged,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Device.width,
        padding: AppPadding.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        margin: AppPadding.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.px),
          color: Theme.of(context).cardColor,
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      Theme.of(context).primaryTextTheme.titleSmall?.semibold,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.semibold,
                ),
              ],
            ),
            _buildSwitchOrIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchOrIcon(BuildContext context) {
    if (isSwitch) {
      return Switch(
        value: switchValue ?? false,
        onChanged: switchOnChanged,
        activeColor: AppColorsLight.primary,
        activeTrackColor: AppColorsLight.primary.withValues(alpha: 0.3),
        inactiveThumbColor: AppColorsLight.grey,
        inactiveTrackColor: AppColorsLight.background,
      );
    } else {
      return Container(
        padding: AppPadding.all(AppSpacing.sm),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1.px,
          ),
        ),
        child: Icon(
          icon ?? Icons.arrow_forward_ios_rounded,
          size: 24.px,
          color: Theme.of(context).iconTheme.color,
        ),
      );
    }
  }
}
