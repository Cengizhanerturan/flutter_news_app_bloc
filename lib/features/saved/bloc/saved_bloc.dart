import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:logging/logging.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final NewsLocalDataSource _newsLocalDataSource;
  SavedBloc(this._newsLocalDataSource) : super(Loading()) {
    on<FetchSavedNews>(_onFetchSavedNews);
    on<DeleteSavedNews>(_onDeleteSavedNews);
  }

  Future<void> _onFetchSavedNews(
    FetchSavedNews event,
    Emitter<SavedState> emit,
  ) async {
    try {
      emit(Loading());
      final newsList = _newsLocalDataSource.getSavedNewsList();
      if (newsList.isEmpty) {
        emit(Empty());
      } else {
        emit(Success(newsList: newsList));
      }
    } catch (e, st) {
      Logger('SavedBloc').severe('FetchSavedNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  void _onDeleteSavedNews(DeleteSavedNews event, Emitter<SavedState> emit) {
    try {
      if (state is Success) {
        final currentState = state as Success;
        var updatedList = List.of(currentState.newsList)
          ..remove(event.newsModel);
        emit(Success(newsList: updatedList));
      }
    } catch (e, st) {
      Logger('SavedBloc').severe('DeleteSavedNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }
}
