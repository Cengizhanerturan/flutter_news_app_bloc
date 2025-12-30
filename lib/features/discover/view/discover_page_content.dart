import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/core/util/extensions/navigation_extension.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/features/discover/bloc/discover_bloc.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/features/discover/widgets/custom_tabbar.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class DiscoverPageContent extends StatelessWidget {
  final TabController tabController;
  final PageController pageController;
  const DiscoverPageContent(
    this.tabController,
    this.pageController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: StringConstants.DISCOVER_PAGE_TITLE,
                subtitle: StringConstants.DISCOVER_PAGE_SUBTITLE,
              ),
              _buildSearchField(context),
              _buildTabbar(),
              _buildPageView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is Success) {
            return PageView.builder(
              itemCount: NEWS_CATEGORY.values.length,
              controller: pageController,
              onPageChanged: (value) {
                context.read<DiscoverBloc>().add(ChangeTab(value));
                tabController.animateTo(value);
              },
              itemBuilder: (BuildContext context, int pageViewIndex) {
                var newsList =
                    state.newsMap[NEWS_CATEGORY.values[pageViewIndex]] ?? [];
                return _buildNewsList(pageViewIndex, newsList);
              },
            );
          }
          if (state is Error) {
            return CustomErrorWidget(
              error: state.message,
              onRetry: () {
                context.read<DiscoverBloc>().add(FetchNews());
              },
            );
          }
          return LoadingListWidget();
        },
      ),
    );
  }

  Widget _buildNewsList(int pageViewIndex, List<NewsModel> newsList) {
    return ListView.builder(
      itemCount: newsList.length,
      itemBuilder: (BuildContext context, int listViewItemIndex) {
        return NewsCardWidget(newsModel: newsList[listViewItemIndex]);
      },
    );
  }

  Widget _buildTabbar() {
    return BlocSelector<DiscoverBloc, DiscoverState, int>(
      selector: (state) => (state is Success) ? state.currentIndex : 0,
      builder: (context, currentIndex) {
        return CustomTabbar(
          tabController: tabController,
          tabTitleList: NEWS_CATEGORY.values.map((e) => e.name).toList(),
          currentIndex: currentIndex,
          onTap: (index) async {
            context.read<DiscoverBloc>().add(ChangeTab(index));
            await pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return InkWell(
      onTap: () {
        context.toSearch();
      },
      child: CustomTextFormField(
        controller: TextEditingController(),
        hintText: 'Search',
        enabled: false,
        padding: AppPadding.horizontal(AppSpacing.md),
        prefixIcon: ImageIcon(
          AssetImage(AssetConstants.search),
          color: Theme.of(context).hintColor,
        ),
      ),
    );
  }
}
