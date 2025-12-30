import 'package:flutter_news_app/data/datasources/remote/news_api_service.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/data/repositories/news_repository.dart';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'fakes/fake_dio_response.dart';
import 'mocks/mock_news_api_service.dart';

void main() {
  late NewsApiService newsApiService;
  late NewsRepository repository;

  setUp(() {
    newsApiService = MockNewsApiService();
    repository = NewsRepositoryImpl(newsApiService);
  });

  group('getTopHeadlines', () {
    test('getTopHeadlines | 200 -> data -> List<NewsModel> döner', () async {
      when(
        () => newsApiService.getTopHeadlines(
          category: any(named: 'category'),
          pageSize: any(named: 'pageSize'),
        ),
      ).thenAnswer((_) async => fakeDioResponseSuccess());
      final result = await repository.getTopHeadlines();
      expect(result, isA<List<NewsModel>>());
    });

    test(
      'getTopHeadlines | 400 - Bad Request Error -> BAD_REQUEST_ERROR fırlatır',
      () {
        when(
          () => newsApiService.getTopHeadlines(
            category: any(named: 'category'),
            pageSize: any(named: 'pageSize'),
          ),
        ).thenAnswer((_) async => fakeDioResponseError(400));

        final result = repository.getTopHeadlines();
        expect(result, throwsA(isA<BadRequestException>()));
      },
    );

    test(
      'getTopHeadlines | 500 - Internal Server Error -> SERVER_ERROR fırlatır',
      () {
        when(
          () => newsApiService.getTopHeadlines(
            category: any(named: 'category'),
            pageSize: any(named: 'pageSize'),
          ),
        ).thenAnswer((_) async => fakeDioResponseError(500));

        final result = repository.getTopHeadlines();
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });

  group('getSearchNews', () {
    test('getSearchNews | 200 -> data -> List<NewsModel>', () async {
      when(
        () => newsApiService.getSearchNews(
          searchString: any(named: 'searchString'),
        ),
      ).thenAnswer((_) async => fakeDioResponseSuccess());

      final result = await repository.getSearchNews(searchString: 'test');
      expect(result, isA<List<NewsModel>>());
      expect(result.first.author, 'Matt Egan');
    });

    test(
      'getSearchNews | 400 - Bad Request Error -> BAD_REQUEST_ERROR fırlatır',
      () {
        when(
          () => newsApiService.getSearchNews(
            searchString: any(named: 'searchString'),
          ),
        ).thenAnswer((_) async => fakeDioResponseError(400));

        final result = repository.getSearchNews(searchString: 'test');
        expect(result, throwsA(isA<BadRequestException>()));
      },
    );

    test(
      'getSearchNews | 500 - Internal Server Error -> SERVER_ERROR fırlatır',
      () {
        when(
          () => newsApiService.getSearchNews(
            searchString: any(named: 'searchString'),
          ),
        ).thenAnswer((_) async => fakeDioResponseError(500));

        final result = repository.getSearchNews(searchString: 'test');
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
