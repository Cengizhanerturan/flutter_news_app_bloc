part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadInitialSaveStatus extends DetailsEvent {
  final NewsModel? newsModel;

  const LoadInitialSaveStatus(this.newsModel);

  @override
  List<Object?> get props => [newsModel];
}

class ToggleSaveStatus extends DetailsEvent {
  final NewsModel? newsModel;

  const ToggleSaveStatus(this.newsModel);

  @override
  List<Object?> get props => [newsModel];
}
