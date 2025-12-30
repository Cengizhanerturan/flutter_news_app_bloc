part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class Loading extends HomeState {}

class Success extends HomeState {
  final List<NewsModel> newsList;
  final List<NewsModel> sliderNewsList;
  final int sliderPageIndex;
  final String userInformation;

  const Success({
    required this.newsList,
    required this.sliderNewsList,
    this.sliderPageIndex = 0,
    required this.userInformation,
  });

  Success copyWith({
    List<NewsModel>? newsList,
    List<NewsModel>? sliderNewsList,
    int? sliderPageIndex,
    String? userInformation,
  }) {
    return Success(
      newsList: newsList ?? this.newsList,
      sliderNewsList: sliderNewsList ?? this.sliderNewsList,
      sliderPageIndex: sliderPageIndex ?? this.sliderPageIndex,
      userInformation: userInformation ?? this.userInformation,
    );
  }

  @override
  List<Object?> get props => [
    newsList,
    sliderNewsList,
    sliderPageIndex,
    userInformation,
  ];
}

class Empty extends HomeState {}

class Error extends HomeState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
