part of 'verify_mail_bloc.dart';

abstract class VerifyMailEvent extends Equatable {
  const VerifyMailEvent();

  @override
  List<Object?> get props => [];
}

class StartTimer extends VerifyMailEvent {
  final String email;
  final bool isFromAuthPage;
  const StartTimer(this.email, this.isFromAuthPage);

  @override
  List<Object?> get props => [email, isFromAuthPage];
}

class CheckEmailStatus extends VerifyMailEvent {
  final String email;
  final bool isFromAuthPage;
  const CheckEmailStatus(this.email, this.isFromAuthPage);

  @override
  List<Object?> get props => [email, isFromAuthPage];
}

class CheckResendMail extends VerifyMailEvent {}

class ResendMail extends VerifyMailEvent {}
