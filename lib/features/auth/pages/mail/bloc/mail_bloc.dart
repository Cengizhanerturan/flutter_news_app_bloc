import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'mail_event.dart';
part 'mail_state.dart';

class MailBloc extends Bloc<MailEvent, MailState> {
  final UserRepository userRepository;
  MailBloc(this.userRepository) : super(Idle(false)) {
    on<FormChanged>(_onFormChanged);
    on<FormSubmit>(_onFormSubmit);
  }

  void _onFormChanged(FormChanged event, Emitter<MailState> emit) {
    final trimmedEmail = event.email.trim();
    final isValid = Validator.validateEmail(trimmedEmail) == null;
    emit(Idle(isValid));
  }

  Future<void> _onFormSubmit(FormSubmit event, Emitter<MailState> emit) async {
    try {
      emit(Loading());
      final trimmedEmail = event.email.trim();
      var isEmailExist = await userRepository.checkEmailExists(trimmedEmail);
      var authType = isEmailExist ? AUTH_TYPE.LOGIN : AUTH_TYPE.REGISTER;
      emit(Success(authType, trimmedEmail));
    } catch (e) {
      final message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message));
    } finally {
      emit(Idle(false));
    }
  }
}
