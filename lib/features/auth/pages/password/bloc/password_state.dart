part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();

  @override
  List<Object?> get props => [];
}

class Idle extends PasswordState {
  final bool isButtonEnabled;

  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends PasswordState {}

class Success extends PasswordState {
  final bool isVerified;
  final String password;

  const Success(this.password, {this.isVerified = false});

  @override
  List<Object?> get props => [isVerified];
}

class Error extends PasswordState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
