part of 'update_mail_bloc.dart';

abstract class UpdateMailState extends Equatable {
  const UpdateMailState();
  @override
  List<Object?> get props => [];
}

class Idle extends UpdateMailState {
  final bool isButtonEnabled;
  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends UpdateMailState {}

class Success extends UpdateMailState {
  final String message;

  const Success(this.message);

  @override
  List<Object?> get props => [message];
}

class Error extends UpdateMailState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
