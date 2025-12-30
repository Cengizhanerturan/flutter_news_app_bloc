import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'update_user_information_event.dart';
part 'update_user_information_state.dart';

class UpdateUserInformationBloc
    extends Bloc<UpdateUserInformationEvent, UpdateUserInformationState> {
  final UserService userService;
  final UserRepository userRepository;
  UpdateUserInformationBloc(this.userService, this.userRepository)
    : super(Idle(false)) {
    on<LoadUserInformation>(_onLoadUserInformation);
    on<FormSubmit>(_onFormSubmit);
    on<FormChanged>(_onFormChanged);
  }

  void _onLoadUserInformation(
    LoadUserInformation event,
    Emitter<UpdateUserInformationState> emit,
  ) {
    try {
      var user = userService.user;
      final name = user?.name ?? "";
      final surname = user?.surname ?? "";
      event.callback(name, surname);
    } catch (e) {
      emit(Error(StringConstants.DEFAULT_ERROR_MESSAGE));
    } finally {
      emit(Idle(false));
    }
  }

  Future<void> _onFormSubmit(
    FormSubmit event,
    Emitter<UpdateUserInformationState> emit,
  ) async {
    try {
      if (userService.user != null) {
        emit(Loading());
        final name = event.name;
        final surname = event.surname;
        var userModel = userService.user!.copyWith(
          name: name,
          surname: surname,
        );

        await userRepository.updateUserInformation(userModel);
        emit(Success(StringConstants.UPDATE_USER_INFORMATION_SUCCESS_MESSAGE));
      }
    } catch (e) {
      emit(Error(StringConstants.DEFAULT_ERROR_MESSAGE));
    } finally {
      emit(Idle(false));
    }
  }

  Future<void> _onFormChanged(
    FormChanged event,
    Emitter<UpdateUserInformationState> emit,
  ) async {
    try {
      final trimmedName = event.name.trim();
      final trimmedSurname = event.surname.trim();

      final hasChanged =
          trimmedName != userService.user?.name ||
          trimmedSurname != userService.user?.surname;

      final isNameValid = Validator.validateName(trimmedName) == null;
      final isSurnameValid = Validator.validateSurname(trimmedSurname) == null;

      final isValid = hasChanged && isNameValid && isSurnameValid;

      emit(Idle(isValid));
    } catch (e) {
      emit(state);
    }
  }
}
