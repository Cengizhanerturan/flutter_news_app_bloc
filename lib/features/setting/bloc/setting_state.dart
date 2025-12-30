part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class Idle extends SettingState {}

class Loading extends SettingState {}

class Success extends SettingState {}

class Error extends SettingState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
