import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTabbar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitleList;
  final int currentIndex;
  final void Function(int index)? onTap;
  const CustomTabbar({
    super.key,
    required this.tabController,
    required this.tabTitleList,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      onTap: onTap,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      tabs: List.generate(tabTitleList.length, (int index) {
        final title = tabTitleList[index];
        return Tab(
          child: Container(
            padding: AppPadding.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.px),
              color:
                  currentIndex == index
                      ? AppColorsLight.primary
                      : Theme.of(context).cardColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1.px,
              ),
            ),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).primaryTextTheme.bodyMedium?.semibold.copyWith(
                color:
                    currentIndex == index
                        ? AppColorsLight.white
                        : Theme.of(context).unselectedWidgetColor,
              ),
            ),
          ),
        );
      }),
      padding: AppPadding.all(AppSpacing.sm),
      labelPadding: AppPadding.horizontal(AppSpacing.xs),
      indicatorPadding: AppPadding.zero,
      unselectedLabelColor: AppColorsLight.textPrimary,
      labelColor: AppColorsLight.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(30.px),
        color: Colors.transparent,
      ),
    );
  }
}
