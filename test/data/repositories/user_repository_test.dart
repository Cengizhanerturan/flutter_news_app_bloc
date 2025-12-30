import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/datasources/remote/auth_service.dart';
import 'package:flutter_news_app/data/datasources/remote/firestore_service.dart';
import 'package:flutter_news_app/data/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../helper/fakes/fake_user.dart';
import '../../helper/mocks/mock_user.dart';
import 'mocks/mock_auth_service.dart';
import 'mocks/mock_firestore_service.dart';
import 'mocks/mock_user_credential.dart';
import '../../helper/mocks/mock_user_service.dart';

void main() {
  late AuthService authService;
  late FirestoreService firestoreService;
  late UserService userService;
  late UserRepository repository;

  setUp(() {
    authService = MockAuthService();
    firestoreService = MockFirestoreService();
    userService = MockUserService();
    repository = UserRepositoryImpl(authService, firestoreService, userService);
  });

  group('login', () {
    test(
      'login | user null geldigi durumda USER_NOT_FOUND_ERROR_MESSAGE fırlatılır',
      () {
        final userCredential = MockUserCredential();
        when(
          () => authService.login(any(), any()),
        ).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(null);
        final result = repository.login('email', 'password');
        expect(
          result,
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'error message',
              contains(StringConstants.USER_NOT_FOUND_ERROR_MESSAGE),
            ),
          ),
        );
      },
    );

    test(
      'login | kullanıcı girişi yapılıyor ancak email dogrulaması yapılmadıgı için false dönüyor',
      () async {
        final userCredential = MockUserCredential();
        final firebaseAuthUser = MockUser();
        final userModel = fakeUser();
        when(
          () => authService.login(any(), any()),
        ).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(firebaseAuthUser);
        when(() => firebaseAuthUser.uid).thenReturn(userModel.userId);
        when(
          () => firestoreService.getUser(any()),
        ).thenAnswer((_) async => userModel);
        when(() => firebaseAuthUser.emailVerified).thenReturn(false);
        when(
          () => authService.sendEmailVerification(),
        ).thenAnswer((_) async => {});

        final result = await repository.login('email', 'password');

        expect(result, isFalse);
        verify(() => authService.sendEmailVerification()).called(1);
      },
    );

    test(
      'login | kullanıcı girişi yapılıyor, email dogrulamasıda mevcut, true dönüyor',
      () async {
        final userCredential = MockUserCredential();
        final firebaseAuthUser = MockUser();
        final userModel = fakeUser();
        when(
          () => authService.login(any(), any()),
        ).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(firebaseAuthUser);
        when(() => firebaseAuthUser.uid).thenReturn(userModel.userId);
        when(
          () => firestoreService.getUser(any()),
        ).thenAnswer((_) async => userModel);
        when(() => firebaseAuthUser.emailVerified).thenReturn(true);
        when(
          () => authService.sendEmailVerification(),
        ).thenAnswer((_) async => {});

        final result = await repository.login('email', 'password');

        expect(result, isTrue);
        verifyNever(() => authService.sendEmailVerification());
      },
    );
  });

  group('register', () {
    test(
      'register | user null geldigi durumda DEFAULT_ERROR_MESSAGE fırlatır',
      () {
        final userCredential = MockUserCredential();
        when(
          () => authService.register(any(), any()),
        ).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(null);

        final result = repository.register('email', 'password');
        expect(
          result,
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'error message',
              contains(StringConstants.DEFAULT_ERROR_MESSAGE),
            ),
          ),
        );
        verifyNever(() => authService.sendEmailVerification());
      },
    );

    test(
      'register | user null degil, kayıt işlemi başarılı ve kullanıcıya email dogrulama kodu gönderildi',
      () async {
        final userCredential = MockUserCredential();
        final firebaseAuthUser = MockUser();
        when(
          () => authService.register(any(), any()),
        ).thenAnswer((_) async => userCredential);
        when(() => userCredential.user).thenReturn(firebaseAuthUser);
        when(
          () => authService.sendEmailVerification(),
        ).thenAnswer((_) async => {});

        await repository.register('email', 'password');

        verify(() => authService.sendEmailVerification()).called(1);
      },
    );
  });
}
