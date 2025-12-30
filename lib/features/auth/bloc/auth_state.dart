part of 'auth_bloc.dart';

class AuthState {
  final int pageIndex;
  final AUTH_TYPE authType;
  final String email;
  final String password;
  final String name;
  final String surname;

  const AuthState({
    this.pageIndex = 0,
    this.authType = AUTH_TYPE.REGISTER,
    this.email = "",
    this.password = "",
    this.name = "",
    this.surname = "",
  });

  AuthState copyWith({
    int? pageIndex,
    AUTH_TYPE? authType,
    String? email,
    String? password,
    String? name,
    String? surname,
  }) {
    return AuthState(
      pageIndex: pageIndex ?? this.pageIndex,
      authType: authType ?? this.authType,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      surname: surname ?? this.surname,
    );
  }
}
