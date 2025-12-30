part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object?> get props => [];
}

class FetchNews extends DiscoverEvent {}

class ChangeTab extends DiscoverEvent {
  final int index;

  const ChangeTab(this.index);

  @override
  List<Object?> get props => [index];
}
