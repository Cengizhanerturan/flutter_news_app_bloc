import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/widget/custom_cached_network_image.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SliderWidget extends StatelessWidget {
  final double width;
  final double height;
  final List<NewsModel> list;
  final int currentPage;
  final void Function(int) onPageChanged;
  const SliderWidget({
    super.key,
    required this.width,
    required this.height,
    required this.list,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height,
          child: PageView.builder(
            itemCount: list.length,
            onPageChanged: onPageChanged,
            itemBuilder: (BuildContext context, int index) {
              final newsModel = list[index];
              return InkWell(
                onTap: () {
                  context.toDetails(news: newsModel);
                },
                child: Padding(
                  padding: AppPadding.horizontal(AppSpacing.md),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Stack(
                      children: [
                        CustomCachedNetworkImage(
                          imageUrl: newsModel.urlToImage,
                          width: width,
                          height: height,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: height * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColorsLight.black,
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.px),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 6.px,
                          left: 10.px,
                          right: 10.px,
                          child: AutoSizeText(
                            newsModel.title,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .titleSmall
                                ?.semibold
                                .copyWith(color: AppColorsLight.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Positioned(
                          top: 6.px,
                          right: 10.px,
                          child: Container(
                            padding: AppPadding.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              color: AppColorsLight.primary,
                            ),
                            child: Text(
                              newsModel.source.name,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .bodySmall
                                  ?.semibold
                                  .copyWith(color: AppColorsLight.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: AppPadding.vertical(AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(list.length, (index) {
              return Container(
                width: index == currentPage ? 10.px : 8.px,
                height: index == currentPage ? 10.px : 8.px,
                margin: AppPadding.horizontal(AppSpacing.xxs),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == currentPage
                          ? AppColorsLight.primary
                          : AppColorsLight.darkGrey,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
