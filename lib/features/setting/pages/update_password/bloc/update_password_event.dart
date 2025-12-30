part of 'update_password_bloc.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class FormSubmit extends UpdatePasswordEvent {
  final String currentPassword;
  final String password;

  const FormSubmit(this.currentPassword, this.password);

  @override
  List<Object?> get props => [currentPassword, password];
}

class FormChanged extends UpdatePasswordEvent {
  final String currentPassword;
  final String password;
  final String repassword;

  const FormChanged(this.currentPassword, this.password, this.repassword);

  @override
  List<Object?> get props => [currentPassword, password, repassword];
}
