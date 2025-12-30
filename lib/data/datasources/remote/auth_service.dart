import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;

  AuthService({FirebaseAuth? firebaseAuth})
    : _auth = firebaseAuth ?? FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> getCurrentUser() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser;
  }

  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<bool> checkEmailVerification() async {
    if (_auth.currentUser == null) {
      return false;
    }
    await _auth.currentUser!.reload();
    return currentUser!.emailVerified;
  }

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> checkAndSendEmailVerification() async {
    var isUserVerified = await checkEmailVerification();
    if (!isUserVerified) {
      await sendEmailVerification();
    }
  }

  Future<void> changeEmail(String newEmail) async {
    await currentUser?.verifyBeforeUpdateEmail(newEmail);
  }

  Future<void> changePassword(String newPassword) async {
    await currentUser?.updatePassword(newPassword);
  }

  Future<void> reauthenticate(String email, String password) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await currentUser?.reauthenticateWithCredential(credential);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
