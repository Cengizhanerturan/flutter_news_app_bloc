import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/asset_constants.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/theme/app_padding.dart';
import 'package:flutter_news_app/core/theme/app_spacing.dart';
import 'package:flutter_news_app/features/search/bloc/search_bloc.dart';
import 'package:flutter_news_app/widget/custom_back_button.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/custom_text_form_field.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class SearchPageContent extends StatelessWidget {
  final TextEditingController textEditingController;
  const SearchPageContent({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(
              padding: AppPadding.only(
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.md,
              ),
            ),
            TitleWidget(
              title: StringConstants.SEARCH_PAGE_TITLE,
              subtitle: StringConstants.SEARCH_PAGE_SUBTITLE,
            ),
            _buildSearchField(context),
            _buildNewsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsList() {
    return Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is Success) {
            var newsList = state.newsList;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: AppPadding.only(
                    top: index == 0 ? AppSpacing.sm : 0,
                    bottom: index == newsList.length - 1 ? AppSpacing.sm : 0,
                  ),
                  child: NewsCardWidget(newsModel: newsList[index]),
                );
              },
            );
          }

          if (state is Error) {
            return CustomErrorWidget(
              error: state.message,
              onRetry: () {
                context.read<SearchBloc>().add(InitNews());
              },
            );
          }

          return LoadingListWidget();
        },
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return CustomTextFormField(
      controller: textEditingController,
      hintText: 'Search',
      padding: AppPadding.horizontal(AppSpacing.md),
      prefixIcon: ImageIcon(
        AssetImage(AssetConstants.search),
        color: Theme.of(context).hintColor,
      ),
      onChanged: (value) {
        context.read<SearchBloc>().add(SearchNews(value));
      },
    );
  }
}
