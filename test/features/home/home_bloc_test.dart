import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/services/user_service.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/features/home/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/fakes/fake_news.dart';
import '../../helper/fakes/fake_user.dart';
import '../../helper/mocks/mock_user_service.dart';
import 'mocks/mock_news_repository.dart';

void main() {
  late NewsRepository repository;
  late UserService userService;
  late HomeBloc bloc;

  setUp(() {
    repository = MockNewsRepository();
    userService = MockUserService();
    bloc = HomeBloc(repository, userService);
  });

  tearDown(() {
    bloc.close();
  });

  group('FetchNews', () {
    blocTest<HomeBloc, HomeState>(
      'FetchNews | veri geldigi durumda; Loading -> Success',
      build: () {
        when(() => repository.getTopHeadlines()).thenAnswer(
          (_) async => List.generate(10, (index) => fakeNews(index)),
        );
        when(() => userService.user).thenReturn(fakeUser());
        return bloc;
      },
      act: (bloc) => bloc.add(FetchNews()),
      expect:
          () => [
            isA<Loading>(),
            isA<Success>()
                .having((s) => s.newsList.length, 'news list length', 5)
                .having(
                  (s) => s.sliderNewsList.length,
                  'slider news list length',
                  5,
                )
                .having(
                  (s) => s.userInformation,
                  'user information',
                  'Cengizhan Erturan',
                ),
          ],
      verify: (bloc) {
        verify(() => repository.getTopHeadlines()).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'FetchNews | verinin boş geldigi durumda; Loading -> Empty',
      build: () {
        when(() => repository.getTopHeadlines()).thenAnswer((_) async => []);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchNews()),
      expect: () => [isA<Loading>(), isA<Empty>()],
    );

    blocTest<HomeBloc, HomeState>(
      'FetchNews | verinin gelmedigi hata gerçekleşen durumda: Loading -> Error',
      build: () {
        when(() => repository.getTopHeadlines()).thenThrow(
          Exception(StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(FetchNews()),
      expect:
          () => [
            isA<Loading>(),
            isA<Error>().having(
              (e) => e.message,
              'error message',
              contains(StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE),
            ),
          ],
    );
  });

  group('SliderPageChanged', () {
    blocTest<HomeBloc, HomeState>(
      'SliderPageChanged | Success state icindeyken sliderPageIndex degisir',
      build: () {
        when(() => repository.getTopHeadlines()).thenAnswer(
          (_) async => List.generate(10, (index) => fakeNews(index)),
        );
        when(() => userService.user).thenReturn(fakeUser());
        return bloc;
      },
      act: (bloc) async {
        bloc.add(FetchNews());
        bloc.add(SliderPageChanged(3));
      },
      expect:
          () => [
            isA<Loading>(),
            isA<Success>(),
            isA<Success>().having(
              (s) => s.sliderPageIndex,
              'slider page index',
              3,
            ),
          ],
    );
  });
}
