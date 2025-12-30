part of 'saved_bloc.dart';

abstract class SavedState extends Equatable {
  const SavedState();

  @override
  List<Object?> get props => [];
}

class Loading extends SavedState {}

class Success extends SavedState {
  final List<NewsModel> newsList;

  const Success({required this.newsList});

  @override
  List<Object?> get props => [newsList];
}

class Empty extends SavedState {}

class Error extends SavedState {
  final String message;
  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
