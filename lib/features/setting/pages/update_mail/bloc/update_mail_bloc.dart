import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'update_mail_event.dart';
part 'update_mail_state.dart';

class UpdateMailBloc extends Bloc<UpdateMailEvent, UpdateMailState> {
  final UserService userService;
  final UserRepository userRepository;
  UpdateMailBloc(this.userService, this.userRepository) : super(Idle(false)) {
    on<LoadEmail>(_onLoadEmail);
    on<FormSubmit>(_onFormSubmit);
    on<FormChanged>(_onFormChanged);
  }

  void _onLoadEmail(LoadEmail event, Emitter<UpdateMailState> emit) {
    try {
      if (userService.user != null) {
        final currentEmail = userService.user!.email;
        event.callback(currentEmail);
      }
    } catch (e) {
      emit(Error(StringConstants.DEFAULT_ERROR_MESSAGE));
    } finally {
      emit(Idle(false));
    }
  }

  Future<void> _onFormSubmit(
    FormSubmit event,
    Emitter<UpdateMailState> emit,
  ) async {
    try {
      final user = userService.user;
      if (user != null) {
        emit(Loading());
        final currentEmail = user.email;
        final email = event.email.trim();
        final password = event.password.trim();
        var isEmailExists = await userRepository.checkEmailExists(email);
        if (isEmailExists) {
          emit(Error(StringConstants.MAIL_ALREADY_EXISTS_ERROR_MESSAGE));
        } else {
          await userRepository.changeEmail(currentEmail, password, email);
          var userModel = user.copyWith(email: email);
          await userRepository.updateUserInformation(userModel);
          emit(Success(StringConstants.UPDATE_MAIL_SUCCESS_MESSAGE));
        }
      }
    } catch (e) {
      final message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message));
    } finally {
      emit(Idle(false));
    }
  }

  Future<void> _onFormChanged(
    FormChanged event,
    Emitter<UpdateMailState> emit,
  ) async {
    try {
      final trimmedEmail = event.email.trim();
      final trimmedPassword = event.password.trim();

      final hasChanged = trimmedEmail != userService.user?.email;

      final isEmailValid = Validator.validateEmail(trimmedEmail) == null;
      final isPasswordValid =
          Validator.validatePassword(trimmedPassword) == null;

      final isValid = hasChanged && isEmailValid && isPasswordValid;

      emit(Idle(isValid));
    } catch (e) {
      emit(state);
    }
  }
}
