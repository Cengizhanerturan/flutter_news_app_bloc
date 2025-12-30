import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/features/saved/bloc/saved_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/fakes/fake_news.dart';
import 'mocks/mock_news_local_data_source.dart';

void main() {
  late NewsLocalDataSource newsLocalDataSource;
  late SavedBloc bloc;

  setUp(() {
    newsLocalDataSource = MockNewsLocalDataSource();
    bloc = SavedBloc(newsLocalDataSource);
  });

  tearDown(() {
    bloc.close();
  });

  group('FetchSavedNews', () {
    blocTest<SavedBloc, SavedState>(
      'FetchSavedNews | datanın boş geldigi durumda: Loading -> Empty',
      build: () {
        when(() => newsLocalDataSource.getSavedNewsList()).thenReturn([]);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchSavedNews()),
      expect: () => [isA<Loading>(), isA<Empty>()],
    );

    blocTest<SavedBloc, SavedState>(
      'FetchSavedNews | datanın dolu geldigi durumda: Loading -> Success',
      build: () {
        when(
          () => newsLocalDataSource.getSavedNewsList(),
        ).thenReturn([fakeNews()]);
        return bloc;
      },
      act: (bloc) => bloc.add(FetchSavedNews()),
      expect:
          () => [
            isA<Loading>(),
            isA<Success>().having(
              (s) => s.newsList.length,
              'news list length',
              1,
            ),
          ],
    );

    blocTest<SavedBloc, SavedState>(
      'FetchSavedNews | datanın gelmedigi hata gerçekleşen durumda: Loading -> Error',
      build: () {
        when(() => newsLocalDataSource.getSavedNewsList()).thenThrow(
          Exception(StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(FetchSavedNews()),
      expect:
          () => [
            isA<Loading>(),
            isA<Error>().having(
              (e) => e.message.toString(),
              'error message',
              contains(StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE),
            ),
          ],
    );
  });

  group('DeleteSavedNews', () {
    blocTest(
      'DeleteSavedNews | success durumundayken kayıtlı olan newsModeli listeden siler ve yeni listeyi emit eder',
      build: () {
        when(
          () => newsLocalDataSource.getSavedNewsList(),
        ).thenReturn([fakeNews()]);
        return bloc;
      },
      act: (bloc) async {
        bloc.add(FetchSavedNews());
        bloc.add(DeleteSavedNews(newsModel: fakeNews()));
      },
      expect:
          () => [
            isA<Loading>(),
            isA<Success>(),
            isA<Success>().having(
              (s) => s.newsList.isEmpty,
              'news list length',
              true,
            ),
          ],
    );
  });
}
