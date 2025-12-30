part of 'saved_bloc.dart';

abstract class SavedEvent extends Equatable {
  const SavedEvent();

  @override
  List<Object?> get props => [];
}

class FetchSavedNews extends SavedEvent {}

class DeleteSavedNews extends SavedEvent {
  final NewsModel newsModel;

  const DeleteSavedNews({required this.newsModel});

  @override
  List<Object?> get props => [newsModel];
}
