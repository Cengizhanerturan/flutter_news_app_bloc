part of 'registration_details_bloc.dart';

abstract class RegistrationDetailsState extends Equatable {
  const RegistrationDetailsState();

  @override
  List<Object?> get props => [];
}

class Idle extends RegistrationDetailsState {
  final bool isButtonEnabled;

  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends RegistrationDetailsState {}

class Success extends RegistrationDetailsState {
  final String name;
  final String surname;

  const Success(this.name, this.surname);

  @override
  List<Object?> get props => [name, surname];
}

class Error extends RegistrationDetailsState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
