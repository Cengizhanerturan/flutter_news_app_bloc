import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/data/models/user_model.dart';
import 'package:flutter_news_app/data/datasources/remote/firestore_service.dart';
import 'package:flutter_news_app/data/datasources/remote/auth_service.dart';
import 'package:flutter_news_app/core/services/user_service.dart';

abstract class UserRepository {
  bool isUserAvailable();

  Future<bool> login(String email, String password);

  Future<void> register(String email, String password);

  Future<void> changeEmail(String email, String password, String newEmail);

  Future<void> changePassword(String password, String newPassword);

  Future<void> createUserInformation(UserModel userModel);

  Future<void> updateUserInformation(UserModel userModel);

  Future<bool> checkEmailVerification();

  Future<void> sendEmailVerification();

  Future<bool> initUser();

  Future<bool> checkEmailExists(String email);

  Future<User?> getUser();

  Future<void> logout();
}

class UserRepositoryImpl extends UserRepository {
  final AuthService _authService;
  final FirestoreService _firestoreService;
  final UserService _userService;

  UserRepositoryImpl(
    this._authService,
    this._firestoreService,
    this._userService,
  );

  @override
  bool isUserAvailable() {
    return _authService.currentUser != null;
  }

  @override
  Future<bool> login(String email, String password) async {
    final userCredential = await _authService.login(email, password);
    if (userCredential.user == null) {
      throw Exception(StringConstants.USER_NOT_FOUND_ERROR_MESSAGE);
    }
    var userModel = await _firestoreService.getUser(userCredential.user!.uid);
    _userService.user = userModel;
    if (!userCredential.user!.emailVerified) {
      _authService.sendEmailVerification();
      return false;
    }
    return true;
  }

  @override
  Future<void> register(String email, String password) async {
    final userCredential = await _authService.register(email, password);
    if (userCredential.user == null) {
      throw Exception(StringConstants.DEFAULT_ERROR_MESSAGE);
    }
    await _authService.sendEmailVerification();
  }

  @override
  Future<void> changeEmail(
    String email,
    String password,
    String newEmail,
  ) async {
    await _authService.reauthenticate(email, password);
    await _authService.changeEmail(newEmail);
  }

  @override
  Future<void> changePassword(String password, String newPassword) async {
    var email = _userService.user!.email;
    await _authService.reauthenticate(email, password);
    await _authService.changePassword(newPassword);
  }

  @override
  Future<void> createUserInformation(UserModel userModel) async {
    await _firestoreService.createUser(userModel);
    _userService.user = userModel;
  }

  @override
  Future<void> updateUserInformation(UserModel userModel) async {
    await _firestoreService.updateUser(userModel);
    _userService.user = userModel;
  }

  @override
  Future<bool> checkEmailVerification() async {
    return await _authService.checkEmailVerification();
  }

  @override
  Future<void> sendEmailVerification() async {
    return await _authService.sendEmailVerification();
  }

  @override
  Future<bool> initUser() async {
    var currentUser = await _authService.getCurrentUser();
    if (currentUser == null) {
      return false;
    }
    var userId = currentUser.uid;
    var userModel = await _firestoreService.getUser(userId);
    if (userModel == null) {
      return false;
    }
    _userService.user = userModel;
    return true;
  }

  @override
  Future<bool> checkEmailExists(String email) async {
    return await _firestoreService.checkEmailExists(email);
  }

  @override
  Future<User?> getUser() async {
    try {
      return await _authService.getCurrentUser();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await _authService.logout();
  }
}
