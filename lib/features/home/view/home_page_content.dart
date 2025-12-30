import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/theme/app_colors.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/theme/theme_extension.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/error_image_widget.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/features/home/widgets/loading_slider_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/features/home/widgets/slider_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),
              _buildBreakingNews(context),
              _buildRecommendatitonNews(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendatitonNews(BuildContext context) {
    return Column(
      children: [
        _buildTitleArea(context, StringConstants.RECOMMENDATION),
        BlocBuilder<HomeBloc, HomeState>(
          buildWhen: (previous, current) {
            if (previous is Success && current is Success) {
              return previous.newsList != current.newsList;
            }
            return previous.runtimeType != current.runtimeType;
          },
          builder: (context, state) {
            if (state is Loading) return LoadingListWidget();
            if (state is Success) {
              return Padding(
                padding: AppPadding.vertical(AppSpacing.sm),
                child: ListView.builder(
                  itemCount: state.newsList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final newsModel = state.newsList[index];
                    return NewsCardWidget(newsModel: newsModel);
                  },
                ),
              );
            }
            if (state is Error) {
              return CustomErrorWidget(
                error: state.message,
                onRetry: () {
                  context.read<HomeBloc>().add(FetchNews());
                },
              );
            }
            return LoadingListWidget();
          },
        ),
      ],
    );
  }

  Widget _buildBreakingNews(BuildContext context) {
    return Padding(
      padding: AppPadding.vertical(AppSpacing.sm),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTitleArea(context, StringConstants.BREAKING_NEWS),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is Loading) return LoadingSliderWidget();
              if (state is Success) {
                return Padding(
                  padding: AppPadding.vertical(AppSpacing.sm),
                  child: SliderWidget(
                    width: Device.width,
                    height: Device.width * 0.5,
                    list: state.sliderNewsList,
                    currentPage: state.sliderPageIndex,
                    onPageChanged: (index) {
                      context.read<HomeBloc>().add(SliderPageChanged(index));
                    },
                  ),
                );
              }
              if (state is Error) {
                return Padding(
                  padding: AppPadding.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Column(
                    children: [
                      ErrorImageWidget(
                        width: Device.width,
                        height: Device.width * 0.5,
                      ),
                      Padding(
                        padding: AppPadding.vertical(AppSpacing.md),
                        child: SizedBox(),
                      ),
                    ],
                  ),
                );
              }
              return LoadingSliderWidget();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTitleArea(BuildContext context, String title) {
    return Padding(
      padding: AppPadding.horizontal(AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleText(context, title),
          _buildViewAllButton(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConstants.WELCOME,
                style: Theme.of(context).textTheme.bodySmall?.semibold,
              ),
              BlocSelector<HomeBloc, HomeState, String>(
                selector:
                    (state) => state is Success ? state.userInformation : "",
                builder: (context, userInformation) {
                  return Text(
                    userInformation,
                    style:
                        Theme.of(context).primaryTextTheme.bodySmall?.semibold,
                  );
                },
              ),
            ],
          ),
          _buildSearchIcon(context),
        ],
      ),
    );
  }

  Widget _buildSearchIcon(BuildContext context) {
    return InkWell(
      onTap: () async {
        context.toSearch();
      },
      child: Container(
        padding: AppPadding.all(AppSpacing.sm),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
          border: Border.all(color: Theme.of(context).dividerColor, width: 1),
        ),
        child: ImageIcon(
          AssetImage(AssetConstants.search),
          color: Theme.of(context).iconTheme.color,
          size: 20.px,
        ),
      ),
    );
  }

  Widget _buildTitleText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).primaryTextTheme.titleSmall?.semibold,
    );
  }

  Widget _buildViewAllButton(BuildContext context) {
    return InkWell(
      onTap: () => context.toDiscover(),
      child: Text(
        StringConstants.VIEW_ALL,
        style: Theme.of(context).primaryTextTheme.bodySmall?.semibold.copyWith(
          color: AppColorsLight.primary,
        ),
      ),
    );
  }
}
