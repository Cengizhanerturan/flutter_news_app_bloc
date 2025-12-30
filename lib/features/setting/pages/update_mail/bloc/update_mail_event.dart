part of 'update_mail_bloc.dart';

abstract class UpdateMailEvent extends Equatable {
  const UpdateMailEvent();

  @override
  List<Object?> get props => [];
}

class FormSubmit extends UpdateMailEvent {
  final String email;
  final String password;

  const FormSubmit(this.email, this.password);

  @override
  List<Object?> get props => [email];
}

class LoadEmail extends UpdateMailEvent {
  final void Function(String email) callback;
  const LoadEmail({required this.callback});
}

class FormChanged extends UpdateMailEvent {
  final String email;
  final String password;

  const FormChanged(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
