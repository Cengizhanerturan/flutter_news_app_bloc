part of 'registration_details_bloc.dart';

abstract class RegistrationDetailsEvent extends Equatable {
  const RegistrationDetailsEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends RegistrationDetailsEvent {
  final String name;
  final String surname;

  const FormChanged(this.name, this.surname);

  @override
  List<Object?> get props => [name, surname];
}

class FormSubmit extends RegistrationDetailsEvent {
  final String name;
  final String surname;
  final String email;

  const FormSubmit(this.name, this.surname, this.email);

  @override
  List<Object?> get props => [name, surname, email];
}
