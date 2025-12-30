part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends PasswordEvent {
  final AUTH_TYPE authType;
  final String password;
  final String repassword;

  const FormChanged(this.authType, this.password, {this.repassword = ""});

  @override
  List<Object?> get props => [authType, password, repassword];
}

class FormSubmit extends PasswordEvent {
  final AUTH_TYPE authType;
  final String email;
  final String password;

  const FormSubmit(this.authType, this.email, this.password);

  @override
  List<Object?> get props => [authType, email, password];
}
