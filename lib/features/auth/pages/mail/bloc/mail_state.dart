part of 'mail_bloc.dart';

abstract class MailState extends Equatable {
  const MailState();

  @override
  List<Object?> get props => [];
}

class Idle extends MailState {
  final bool isButtonEnabled;

  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends MailState {}

class Success extends MailState {
  final AUTH_TYPE authType;
  final String email;

  const Success(this.authType, this.email);

  @override
  List<Object?> get props => [authType];
}

class Error extends MailState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
