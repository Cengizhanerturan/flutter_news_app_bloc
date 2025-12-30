import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/core/util/extensions/extensions.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel newsModel;
  final bool isFromSavedPage;
  final void Function(NewsModel? unfavoriteNews)? onBack;
  const NewsCardWidget({
    super.key,
    required this.newsModel,
    this.isFromSavedPage = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        NewsModel? unfavoriteNews = await context.toDetails(
          news: newsModel,
          isFromSaved: isFromSavedPage,
        );
        if (onBack != null) {
          onBack!(unfavoriteNews);
        }
      },
      child: Container(
        height: Device.width * 0.25,
        padding: AppPadding.horizontal(AppSpacing.md),
        margin: AppPadding.only(bottom: AppSpacing.sm),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedNetworkImage(
              imageUrl: newsModel.urlToImage,
              width: Device.width * 0.25,
              height: Device.width * 0.25,
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
                      child: Text(
                        newsModel.source.name,
                        style: Theme.of(context).textTheme.bodySmall?.semibold,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          newsModel.title,
                          maxLines: 2,
                          style:
                              Theme.of(
                                context,
                              ).primaryTextTheme.bodyMedium?.semibold,
                          maxFontSize:
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodyMedium!
                                  .fontSize!
                                  .floorToDouble(),
                          minFontSize:
                              Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall!
                                  .fontSize!
                                  .floorToDouble(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppPadding.vertical(AppSpacing.xs),
                      child: Text(
                        newsModel.publishedAt.formattedDate,
                        style: Theme.of(context).textTheme.bodySmall?.semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
