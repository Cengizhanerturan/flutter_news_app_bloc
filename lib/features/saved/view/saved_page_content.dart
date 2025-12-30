import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/features/saved/bloc/saved_bloc.dart';
import 'package:flutter_news_app/widget/custom_error_widget.dart';
import 'package:flutter_news_app/widget/loading_list_widget.dart';
import 'package:flutter_news_app/widget/news_card_widget.dart';
import 'package:flutter_news_app/widget/title_widget.dart';

class SavedPageContent extends StatelessWidget {
  const SavedPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<SavedBloc>().add(FetchSavedNews());
          },
          backgroundColor: Theme.of(context).cardColor,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: StringConstants.SAVED_PAGE_TITLE,
                subtitle: StringConstants.SAVED_PAGE_SUBTITLE,
              ),
              _buildBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Expanded(
      child: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          if (state is Success) {
            return ListView.builder(
              itemCount: state.newsList.length,
              itemBuilder: (context, index) {
                final newsModel = state.newsList[index];
                return NewsCardWidget(
                  newsModel: newsModel,
                  isFromSavedPage: true,
                  onBack: (unfavoriteNews) {
                    if (unfavoriteNews != null) {
                      context.read<SavedBloc>().add(
                        DeleteSavedNews(newsModel: newsModel),
                      );
                    }
                  },
                );
              },
            );
          }
          if (state is Empty) {
            return SizedBox();
          }
          if (state is Error) {
            return CustomErrorWidget(
              error: state.message,
              onRetry: () {
                context.read<SavedBloc>().add(FetchSavedNews());
              },
            );
          }
          return LoadingListWidget();
        },
      ),
    );
  }
}
