import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingSliderWidget extends StatelessWidget {
  const LoadingSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.vertical(AppSpacing.sm),
      child: Column(
        children: [
          SizedBox(
            height: Device.width * 0.5,
            child: Padding(
              padding: AppPadding.horizontal(AppSpacing.md),
              child: SizedBox(
                width: Device.width,
                height: Device.width * 0.5,
                child: SkeletonAnimation(
                  shimmerColor: Theme.of(
                    context,
                  ).dividerColor.withValues(alpha: 0.5),
                  gradientColor: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(10.px),
                  child: Container(
                    width: Device.width,
                    height: Device.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.px),
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: AppPadding.vertical(AppSpacing.xs),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  width: 10.px,
                  height: 10.px,
                  margin: AppPadding.horizontal(AppSpacing.xxs),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
