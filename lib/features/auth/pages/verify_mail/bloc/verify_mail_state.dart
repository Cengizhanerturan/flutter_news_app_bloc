part of 'verify_mail_bloc.dart';

abstract class VerifyMailState extends Equatable {
  const VerifyMailState();

  @override
  List<Object?> get props => [];
}

class Loading extends VerifyMailState {
  final bool isResendMail;
  final int time;

  const Loading({this.isResendMail = false, this.time = 60});

  Loading copyWith({bool? isResendMail, int? time}) {
    return Loading(
      isResendMail: isResendMail ?? this.isResendMail,
      time: time ?? this.time,
    );
  }

  @override
  List<Object?> get props => [isResendMail, time];
}

class Success extends VerifyMailState {}

class Error extends VerifyMailState {
  final String message;
  final bool isTokenExpired;
  const Error(this.message, this.isTokenExpired);

  @override
  List<Object?> get props => [message, isTokenExpired];
}
