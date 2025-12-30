import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingNewsCardWidget extends StatelessWidget {
  const LoadingNewsCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Device.width * 0.25,
      padding: AppPadding.horizontal(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonAnimation(
            shimmerColor: Theme.of(context).dividerColor.withValues(alpha: 0.5),
            gradientColor: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.circular(10.px),
            child: Container(
              width: Device.width * 0.25,
              height: Device.width * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.px),
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppPadding.only(left: AppSpacing.sm),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: AppPadding.vertical(AppSpacing.xs),
                    child: SkeletonAnimation(
                      shimmerColor: Theme.of(
                        context,
                      ).dividerColor.withValues(alpha: 0.5),
                      gradientColor: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(10.px),
                      child: Container(
                        width: Device.width * 0.35,
                        height: 14.px,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.px),
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonAnimation(
                        shimmerColor: Theme.of(
                          context,
                        ).dividerColor.withValues(alpha: 0.5),
                        gradientColor: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(10.px),
                        child: Container(
                          height: 14.px,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.px),
                      SkeletonAnimation(
                        shimmerColor: Theme.of(
                          context,
                        ).dividerColor.withValues(alpha: 0.5),
                        gradientColor: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(10.px),
                        child: Container(
                          width: Device.width * 0.5,
                          height: 14.px,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.px),
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: AppPadding.vertical(AppSpacing.xs),
                    child: SkeletonAnimation(
                      shimmerColor: Theme.of(
                        context,
                      ).dividerColor.withValues(alpha: 0.5),
                      gradientColor: Theme.of(context).dividerColor,
                      borderRadius: BorderRadius.circular(10.px),
                      child: Container(
                        width: Device.width * 0.2,
                        height: 14.px,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.px),
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
