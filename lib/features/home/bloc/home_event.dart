part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchNews extends HomeEvent {}

class SliderPageChanged extends HomeEvent {
  final int pageIndex;

  const SliderPageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}
