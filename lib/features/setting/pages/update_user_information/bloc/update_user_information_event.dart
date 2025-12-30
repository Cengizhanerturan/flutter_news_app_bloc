part of 'update_user_information_bloc.dart';

abstract class UpdateUserInformationEvent extends Equatable {
  const UpdateUserInformationEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserInformation extends UpdateUserInformationEvent {
  final void Function(String name, String surname) callback;
  const LoadUserInformation({required this.callback});
}

class FormSubmit extends UpdateUserInformationEvent {
  final String name;
  final String surname;

  const FormSubmit({required this.name, required this.surname});

  @override
  List<Object?> get props => [name, surname];
}

class FormChanged extends UpdateUserInformationEvent {
  final String name;
  final String surname;

  const FormChanged(this.name, this.surname);

  @override
  List<Object?> get props => [name, surname];
}
