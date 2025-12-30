part of 'update_password_bloc.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object?> get props => [];
}

class Idle extends UpdatePasswordState {
  final bool isButtonEnabled;
  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends UpdatePasswordState {}

class Success extends UpdatePasswordState {
  final String message;

  const Success(this.message);

  @override
  List<Object?> get props => [message];
}

class Error extends UpdatePasswordState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
