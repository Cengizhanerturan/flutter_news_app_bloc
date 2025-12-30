part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class UpdateEmail extends AuthEvent {
  final String email;

  const UpdateEmail(this.email);

  @override
  List<Object?> get props => [email];
}

class UpdatePassword extends AuthEvent {
  final String password;

  const UpdatePassword(this.password);

  @override
  List<Object?> get props => [password];
}

class UpdateUserInformation extends AuthEvent {
  final String name;
  final String surname;

  const UpdateUserInformation(this.name, this.surname);

  @override
  List<Object?> get props => [name, surname];
}

class UpdateAuthType extends AuthEvent {
  final AUTH_TYPE authType;

  const UpdateAuthType(this.authType);

  @override
  List<Object?> get props => [authType];
}

class NextPage extends AuthEvent {}

class PreviousPage extends AuthEvent {}
