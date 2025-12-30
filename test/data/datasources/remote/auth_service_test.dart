import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/data/datasources/remote/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helper/mocks/mock_user.dart';
import 'mocks/mock_firebase_auth.dart';

void main() {
  late FirebaseAuth firebaseAuth;
  late AuthService authService;

  setUp(() {
    firebaseAuth = MockFirebaseAuth();
    authService = AuthService(firebaseAuth: firebaseAuth);
  });

  group('checkEmailVerification', () {
    test(
      'checkEmailVerification | currentUser == null oldugu durumda false döner',
      () async {
        when(() => firebaseAuth.currentUser).thenReturn(null);
        final result = await authService.checkEmailVerification();
        expect(result, isFalse);
      },
    );

    test(
      'checkEmailVerification | kullanıcı email adresini dogrulamadıgı durumda false döner',
      () async {
        final user = MockUser();
        when(() => firebaseAuth.currentUser).thenReturn(user);
        when(() => user.reload()).thenAnswer((_) async => {});
        when(() => user.emailVerified).thenReturn(false);
        final result = await authService.checkEmailVerification();
        expect(result, isFalse);
      },
    );

    test(
      'checkEmailVerification | kullanıcı email adresini dogruladıgı durumda true döner',
      () async {
        final user = MockUser();
        when(() => firebaseAuth.currentUser).thenReturn(user);
        when(() => user.reload()).thenAnswer((_) async => {});
        when(() => user.emailVerified).thenReturn(true);
        final result = await authService.checkEmailVerification();
        expect(result, isTrue);
      },
    );
  });

  group('checkAndSendEmailVerification', () {
    test(
      'checkAndSendEmailVerification | kullanıcı email adresini dogrulamadıgı durumda dogrulama maili gönderilir',
      () async {
        final user = MockUser();
        when(() => firebaseAuth.currentUser).thenReturn(user);
        when(() => user.reload()).thenAnswer((_) async => {});
        when(() => user.emailVerified).thenReturn(false);
        when(() => user.sendEmailVerification()).thenAnswer((_) async => {});

        await authService.checkAndSendEmailVerification();

        verify(() => user.reload()).called(1);
        verify(() => user.sendEmailVerification()).called(1);
      },
    );

    test(
      'checkAndSendEmailVerification | kullanıcı email adresini dogruladıgı durumda dogrulama maili gönderilmez',
      () async {
        final user = MockUser();
        when(() => firebaseAuth.currentUser).thenReturn(user);
        when(() => user.reload()).thenAnswer((_) async => {});
        when(() => user.emailVerified).thenReturn(true);
        when(() => user.sendEmailVerification()).thenAnswer((_) async => {});

        await authService.checkAndSendEmailVerification();

        verify(() => user.reload()).called(1);
        verifyNever(() => user.sendEmailVerification());
      },
    );
  });
}
