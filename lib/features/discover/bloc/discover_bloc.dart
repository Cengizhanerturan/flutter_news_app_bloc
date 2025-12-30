import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:logging/logging.dart';
import 'package:flutter_news_app/core/util/extensions/extensions.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final NewsRepository _newsRepository;
  DiscoverBloc(this._newsRepository) : super(Loading()) {
    on<FetchNews>(_onFetchNews);
    on<ChangeTab>(_onChangeTab);
  }

  Future<void> _onFetchNews(
    FetchNews event,
    Emitter<DiscoverState> emit,
  ) async {
    try {
      emit(Loading());
      Map<NEWS_CATEGORY, List<NewsModel>> newsMap = {};
      for (var category in NEWS_CATEGORY.values) {
        var news = await _newsRepository.getTopHeadlines(
          category: category == NEWS_CATEGORY.ALL ? null : category.apiName,
        );
        newsMap[category] = news;
      }
      emit(Success(currentIndex: 0, newsMap: newsMap));
    } catch (e, st) {
      Logger('DiscoverBloc').severe('FetchNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<DiscoverState> emit) {
    if (state is Success) {
      final currentState = state as Success;
      emit(currentState.copyWith(currentIndex: event.index));
    }
  }
}
