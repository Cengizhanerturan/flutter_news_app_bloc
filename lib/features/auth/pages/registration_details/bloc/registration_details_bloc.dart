import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/util/validator.dart';
import 'package:flutter_news_app/data/models/user_model.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';

part 'registration_details_event.dart';
part 'registration_details_state.dart';

class RegistrationDetailsBloc
    extends Bloc<RegistrationDetailsEvent, RegistrationDetailsState> {
  final UserRepository userRepository;
  RegistrationDetailsBloc(this.userRepository) : super(Idle(false)) {
    on<FormChanged>(_onFormChanged);
    on<FormSubmit>(_onFormSubmit);
  }

  void _onFormChanged(
    FormChanged event,
    Emitter<RegistrationDetailsState> emit,
  ) {
    final trimmedName = event.name.trim();
    final trimmedSurname = event.surname.trim();

    final isNameValid = Validator.validateName(trimmedName) == null;
    final isSurnameValid = Validator.validateSurname(trimmedSurname) == null;

    final isValid = isNameValid && isSurnameValid;

    emit(Idle(isValid));
  }

  Future<void> _onFormSubmit(
    FormSubmit event,
    Emitter<RegistrationDetailsState> emit,
  ) async {
    try {
      emit(Loading());
      final user = await userRepository.getUser();
      if (user == null) {
        throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
      final trimmedName = event.name.trim();
      final trimmedSurname = event.surname.trim();
      final userModel = UserModel(
        userId: user.uid,
        name: trimmedName,
        surname: trimmedSurname,
        email: event.email,
        createdTime: Timestamp.now(),
      );
      await userRepository.createUserInformation(userModel);
      emit(Success(trimmedName, trimmedSurname));
    } catch (e) {
      emit(Error(StringConstants.DEFAULT_ERROR_MESSAGE));
    }
  }
}
