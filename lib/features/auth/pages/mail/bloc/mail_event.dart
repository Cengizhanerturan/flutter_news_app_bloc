part of 'mail_bloc.dart';

abstract class MailEvent extends Equatable {
  const MailEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends MailEvent {
  final String email;

  const FormChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class FormSubmit extends MailEvent {
  final String email;

  const FormSubmit(this.email);

  @override
  List<Object?> get props => [email];
}
