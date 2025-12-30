import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final UserRepository userRepository;
  SplashBloc(this.userRepository) : super(Idle()) {
    on<CheckRoute>(_onCheckRoute);
  }

  Future<void> _onCheckRoute(
    CheckRoute event,
    Emitter<SplashState> emit,
  ) async {
    emit(Loading());

    if (!userRepository.isUserAvailable() || !await userRepository.initUser()) {
      emit(Success());
      return;
    }

    final isUserVerified = await userRepository.checkEmailVerification();

    emit(Success(isUserAvailable: true, isUserVerified: isUserVerified));
  }
}
