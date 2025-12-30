import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/di/locator.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/features/saved/bloc/saved_bloc.dart';
import 'package:flutter_news_app/features/saved/view/saved_page_content.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedBloc>(
      create:
          (context) =>
              SavedBloc(locator<NewsLocalDataSource>())..add(FetchSavedNews()),
      child: SavedPageContent(),
    );
  }
}
