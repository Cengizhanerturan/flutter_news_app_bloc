part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final bool isSavedNews;
  const DetailsState({this.isSavedNews = false});

  DetailsState copyWith({bool? isSavedNews}) {
    return DetailsState(isSavedNews: isSavedNews ?? this.isSavedNews);
  }

  @override
  List<Object?> get props => [isSavedNews];
}
