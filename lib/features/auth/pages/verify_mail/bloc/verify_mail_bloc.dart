import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/util/helper.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'verify_mail_event.dart';
part 'verify_mail_state.dart';

class VerifyMailBloc extends Bloc<VerifyMailEvent, VerifyMailState> {
  final UserRepository userRepository;
  VerifyMailBloc(this.userRepository) : super(Loading()) {
    on<StartTimer>(_onStartTimer);
    on<CheckEmailStatus>(_onCheckEmailStatus);
    on<CheckResendMail>(_onCheckResendMail);
    on<ResendMail>(_onResendMail);
  }

  Timer? _emailCheckTimer;
  Timer? _resendMailTimer;

  Future<void> _onStartTimer(
    StartTimer event,
    Emitter<VerifyMailState> emit,
  ) async {
    _emailCheckTimer = Timer.periodic(
      Duration(seconds: 3),
      (_) => add(CheckEmailStatus(event.email, event.isFromAuthPage)),
    );

    _resendMailTimer = Timer.periodic(
      Duration(seconds: 1),
      (_) => add(CheckResendMail()),
    );
  }

  Future<void> _onCheckEmailStatus(
    CheckEmailStatus event,
    Emitter<VerifyMailState> emit,
  ) async {
    try {
      bool isVerified;

      if (!event.isFromAuthPage) {
        var currentUser = await userRepository.getUser();
        if (currentUser?.email != event.email) return;

        isVerified = await userRepository.checkEmailVerification();
      } else {
        isVerified = await userRepository.checkEmailVerification();
      }

      if (isVerified) {
        _emailCheckTimer?.cancel();
        emit(Success());
      }
    } catch (e) {
      _emailCheckTimer?.cancel();
      var message = Helper.getFriendlyErrorMessage(e);
      emit(Error(message, Helper.handleTokenExpiredControl(e)));
    }
  }

  Future<void> _onCheckResendMail(
    CheckResendMail event,
    Emitter<VerifyMailState> emit,
  ) async {
    if (state is! Loading) {
      _resendMailTimer?.cancel();
      return;
    }
    final currentState = state as Loading;
    var time = currentState.time - 1;
    if (time <= 0) {
      time = 60;
      emit(currentState.copyWith(time: time, isResendMail: true));
    } else {
      emit(currentState.copyWith(time: time));
    }
  }

  Future<void> _onResendMail(
    ResendMail event,
    Emitter<VerifyMailState> emit,
  ) async {
    if (state is Loading) {
      final currentState = state as Loading;
      await userRepository.sendEmailVerification();
      emit(currentState.copyWith(time: 60, isResendMail: false));
    }
  }

  @override
  Future<void> close() {
    _emailCheckTimer?.cancel();
    _resendMailTimer?.cancel();
    return super.close();
  }
}
