part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object?> get props => [];
}

class Loading extends DiscoverState {}

class Success extends DiscoverState {
  final int currentIndex;
  final Map<NEWS_CATEGORY, List<NewsModel>> newsMap;

  const Success({required this.currentIndex, required this.newsMap});

  Success copyWith({
    int? currentIndex,
    Map<NEWS_CATEGORY, List<NewsModel>>? newsMap,
  }) {
    return Success(
      currentIndex: currentIndex ?? this.currentIndex,
      newsMap: newsMap ?? this.newsMap,
    );
  }

  @override
  List<Object?> get props => [currentIndex, newsMap];
}

class Error extends DiscoverState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
