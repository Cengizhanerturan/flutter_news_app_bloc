part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class Idle extends SplashState {}

class Loading extends SplashState {}

class Success extends SplashState {
  final bool isUserAvailable;
  final bool isUserVerified;

  const Success({this.isUserAvailable = false, this.isUserVerified = false});

  @override
  List<Object?> get props => [isUserAvailable, isUserVerified];
}

class Error extends SplashState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
