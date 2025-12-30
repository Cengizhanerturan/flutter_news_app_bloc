import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/widget/loading_news_card_widget.dart';

class LoadingListWidget extends StatelessWidget {
  const LoadingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.vertical(AppSpacing.sm),
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: AppPadding.only(bottom: AppSpacing.sm),
            child: LoadingNewsCardWidget(),
          );
        },
      ),
    );
  }
}
