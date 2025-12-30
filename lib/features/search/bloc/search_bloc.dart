import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final NewsRepository _newsRepository;
  final List<NewsModel> _initNewsList = [];
  Timer? _debounce;

  SearchBloc(this._newsRepository) : super(Loading()) {
    on<InitNews>(_onInitNews);
    on<SearchNews>(_onSearchNews, transformer: _debounceTransformer());
  }

  Future<void> _onInitNews(InitNews event, Emitter<SearchState> emit) async {
    try {
      emit(Loading());
      if (_initNewsList.isNotEmpty) {
        emit(Success(newsList: _initNewsList));
      } else {
        final newsList = await _newsRepository.getTopHeadlines();
        _initNewsList.addAll(newsList);
        emit(Success(newsList: newsList));
      }
    } catch (e, st) {
      Logger('SearchBloc').severe('InitNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  Future<void> _onSearchNews(
    SearchNews event,
    Emitter<SearchState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) {
        add(InitNews());
        return;
      }

      emit(Loading());
      final newsList = await _newsRepository.getSearchNews(
        searchString: event.query,
      );
      emit(Success(newsList: newsList));
    } catch (e, st) {
      Logger('SearchBloc').severe('SearchNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  EventTransformer<SearchNews> _debounceTransformer() {
    return (events, mapper) {
      return events
          .debounceTime(Duration(milliseconds: 500))
          .asyncExpand(mapper);
    };
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
