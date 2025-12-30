import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UserRepository userRepository;
  UpdatePasswordBloc(this.userRepository) : super(Idle(false)) {
    on<FormSubmit>(_onFormSubmit);
    on<FormChanged>(_onFormChanged);
  }
  Future<void> _onFormSubmit(
    FormSubmit event,
    Emitter<UpdatePasswordState> emit,
  ) async {
    try {
      emit(Loading());
      final currentPassword = event.currentPassword;
      final password = event.password;
      await userRepository.changePassword(currentPassword, password);
      emit(Success(StringConstants.UPDATE_PASSWORD_SUCCESS_MESSAGE));
    } catch (e) {
      final message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message));
    } finally {
      emit(Idle(false));
    }
  }

  void _onFormChanged(FormChanged event, Emitter<UpdatePasswordState> emit) {
    try {
      final trimmedCurrentPassword = event.currentPassword.trim();
      final trimmedPassword = event.password.trim();
      final trimmedRepassword = event.repassword.trim();

      final isDifferent = (trimmedCurrentPassword != trimmedPassword);

      final isCurrentPasswordValid =
          Validator.validatePassword(trimmedCurrentPassword) == null;
      final isPasswordValid =
          Validator.validatePassword(trimmedPassword) == null;
      final isRepasswordValid =
          Validator.validatePassword(trimmedRepassword) == null &&
          (trimmedPassword == trimmedRepassword);

      final isValid =
          isDifferent &&
          isCurrentPasswordValid &&
          isPasswordValid &&
          isRepasswordValid;

      emit(Idle(isValid));
    } catch (e) {
      emit(state);
    }
  }
}
