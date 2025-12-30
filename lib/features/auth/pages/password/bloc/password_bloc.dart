import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final UserRepository userRepository;
  PasswordBloc(this.userRepository) : super(Idle(false)) {
    on<FormChanged>(_onFormChanged);
    on<FormSubmit>(_onFormSubmit);
  }

  void _onFormChanged(FormChanged event, Emitter<PasswordState> emit) {
    final trimmedPassword = event.password.trim();
    final isValidPassword = Validator.validatePassword(trimmedPassword) == null;

    final trimmedRepassword = event.repassword.trim();
    final isValidRepassword =
        Validator.validatePassword(trimmedRepassword) == null;

    final isValid =
        event.authType == AUTH_TYPE.REGISTER
            ? isValidPassword && isValidRepassword
            : isValidPassword;

    emit(Idle(isValid));
  }

  Future<void> _onFormSubmit(
    FormSubmit event,
    Emitter<PasswordState> emit,
  ) async {
    try {
      emit(Loading());
      final trimmedEmail = event.email.trim();
      final trimmedPassword = event.password.trim();
      var isVerified = false;
      if (event.authType == AUTH_TYPE.REGISTER) {
        await userRepository.register(trimmedEmail, trimmedPassword);
      } else {
        isVerified = await userRepository.login(trimmedEmail, trimmedPassword);
      }
      emit(Success(trimmedPassword, isVerified: isVerified));
    } catch (e) {
      final message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message));
    }
  }
}
