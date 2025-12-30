import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/data/models/news_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final NewsLocalDataSource newsLocalDataSource;

  DetailsBloc(this.newsLocalDataSource) : super(DetailsState()) {
    on<LoadInitialSaveStatus>(_onFetchIsSaved);
    on<ToggleSaveStatus>(_onToogleSave);
  }

  void _onFetchIsSaved(
    LoadInitialSaveStatus event,
    Emitter<DetailsState> emit,
  ) {
    try {
      final newsModel = event.newsModel;
      if (newsModel == null) {
        emit(DetailsState());
        return;
      }
      final isSaved = newsLocalDataSource.getIsSaved(newsModel);
      emit(DetailsState(isSavedNews: isSaved));
    } catch (e) {
      emit(DetailsState());
    }
  }

  Future<void> _onToogleSave(
    ToggleSaveStatus event,
    Emitter<DetailsState> emit,
  ) async {
    try {
      final newsModel = event.newsModel;
      if (newsModel == null) {
        emit(state);
        return;
      }
      if (state.isSavedNews) {
        await newsLocalDataSource.removeNews(newsModel);
        emit(state.copyWith(isSavedNews: false));
      } else {
        await newsLocalDataSource.saveNews(newsModel);
        emit(state.copyWith(isSavedNews: true));
      }
    } catch (e) {
      emit(state);
    }
  }
}
