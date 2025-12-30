import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<UpdateEmail>(_onUpdateEmail);
    on<UpdatePassword>(_onUpdatePassword);
    on<UpdateUserInformation>(_onUpdateUserInformation);
    on<UpdateAuthType>(_onUpdateAuthType);
    on<PreviousPage>(_onPreviousPage);
    on<NextPage>(_onNextPage);
  }

  void _onUpdateEmail(UpdateEmail event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onUpdatePassword(UpdatePassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onUpdateUserInformation(
    UpdateUserInformation event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(name: event.name, surname: event.surname));
  }

  void _onUpdateAuthType(UpdateAuthType event, Emitter<AuthState> emit) {
    emit(state.copyWith(authType: event.authType));
  }

  void _onPreviousPage(PreviousPage event, Emitter<AuthState> emit) {
    emit(state.copyWith(pageIndex: state.pageIndex - 1));
  }

  void _onNextPage(NextPage event, Emitter<AuthState> emit) {
    emit(state.copyWith(pageIndex: state.pageIndex + 1));
  }
}
