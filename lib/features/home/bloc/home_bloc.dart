import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:logging/logging.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository _newsRepository;
  final UserService _userService;

  HomeBloc(this._newsRepository, this._userService) : super(Loading()) {
    on<FetchNews>(_onFetchNews);
    on<SliderPageChanged>(_onSliderPageChanged);
  }

  Future<void> _onFetchNews(FetchNews event, Emitter<HomeState> emit) async {
    try {
      emit(Loading());
      var data = await _newsRepository.getTopHeadlines();
      if (data.isNotEmpty) {
        final sliderNewsList = data.sublist(0, 5);
        final newsList = data.sublist(5);

        final name = _userService.user!.name;
        final surname = _userService.user!.surname;
        final userInformation = "$name $surname";

        emit(
          Success(
            newsList: newsList,
            sliderNewsList: sliderNewsList,
            userInformation: userInformation,
          ),
        );
      } else {
        emit(Empty());
      }
    } catch (e, st) {
      Logger('HomeBloc').severe('FetchNews failed', e, st);
      emit(Error(Helper.getFriendlyErrorMessage(e)));
    }
  }

  FutureOr<void> _onSliderPageChanged(
    SliderPageChanged event,
    Emitter<HomeState> emit,
  ) {
    if (state is Success) {
      final newState = (state as Success).copyWith(
        sliderPageIndex: event.pageIndex,
      );
      emit(newState);
    }
  }
}
