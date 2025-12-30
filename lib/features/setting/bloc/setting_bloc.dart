import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final UserRepository userRepository;
  SettingBloc(this.userRepository) : super(Idle()) {
    on<Logout>(_onLogout);
  }

  Future<void> _onLogout(Logout event, Emitter<SettingState> emit) async {
    try {
      emit(Loading());
      await userRepository.logout();
      emit(Success());
    } catch (e) {
      final message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message));
      emit(Idle());
    }
  }
}
