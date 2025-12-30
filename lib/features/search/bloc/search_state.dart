part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class Loading extends SearchState {}

class Success extends SearchState {
  final List<NewsModel> newsList;

  const Success({required this.newsList});

  @override
  List<Object?> get props => [newsList];
}

class Error extends SearchState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
