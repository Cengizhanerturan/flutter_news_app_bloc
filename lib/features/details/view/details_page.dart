import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/features/details/bloc/details_bloc.dart';
import 'package:flutter_news_app/features/details/view/details_page_content.dart';

class DetailsPage extends StatelessWidget {
  final NewsModel? newsModel;
  final bool isFromSavedPage;
  const DetailsPage({
    super.key,
    required this.newsModel,
    required this.isFromSavedPage,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DetailsBloc(locator<NewsLocalDataSource>())
                ..add(LoadInitialSaveStatus(newsModel)),
      child: DetailsPageContent(
        newsModel: newsModel,
        isFromSavedPage: isFromSavedPage,
      ),
    );
  }
}
