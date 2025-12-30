part of 'update_user_information_bloc.dart';

abstract class UpdateUserInformationState extends Equatable {
  const UpdateUserInformationState();

  @override
  List<Object?> get props => [];
}

class Idle extends UpdateUserInformationState {
  final bool isButtonEnabled;
  const Idle(this.isButtonEnabled);

  @override
  List<Object?> get props => [isButtonEnabled];
}

class Loading extends UpdateUserInformationState {
  const Loading();
}

class Success extends UpdateUserInformationState {
  final String message;

  const Success(this.message);

  @override
  List<Object?> get props => [message];
}

class Error extends UpdateUserInformationState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
