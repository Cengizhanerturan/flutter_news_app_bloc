part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class InitNews extends SearchEvent {}

class SearchNews extends SearchEvent {
  final String query;

  const SearchNews(this.query);

  @override
  List<Object?> get props => [query];
}
