import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ErrorImageWidget extends StatelessWidget {
  final double width;
  final double height;
  const ErrorImageWidget({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.px),
        color: Theme.of(context).cardColor,
        border: Border.all(color: Theme.of(context).dividerColor, width: 1.px),
      ),
      child: Icon(
        Icons.image,
        color: AppColorsLight.textSecondary.withValues(alpha: 0.5),
        size: 50.px,
      ),
    );
  }
}
