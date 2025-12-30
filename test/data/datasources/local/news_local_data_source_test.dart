import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:flutter_news_app/data/datasources/local/news_local_data_source.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helper/fakes/fake_news.dart';
import 'mocks/mock_box.dart';

void main() {
  late Box box;
  late NewsLocalDataSource newsLocalDataSource;

  setUp(() {
    box = MockBox();
    newsLocalDataSource = NewsLocalDataSource(box);
  });

  test(
    'saveNews | box.get ile kayıtlı haberler cekılır, ardından box.put ile verilen haber lokale kaydedilir',
    () async {
      when(
        () => box.get(CacheConstants.keySavedNews, defaultValue: []),
      ).thenReturn([]);
      when(
        () => box.put(CacheConstants.keySavedNews, any()),
      ).thenAnswer((_) async {});

      await newsLocalDataSource.saveNews(fakeNews());

      verify(
        () => box.get(CacheConstants.keySavedNews, defaultValue: []),
      ).called(1);
      verify(() => box.put(CacheConstants.keySavedNews, any())).called(1);
    },
  );

  test(
    'removeNews | box.get ile kayıtlı haberler çekilir, ardından verilen haber silinerek box.put ile güncel liste lokale kaydedilir.',
    () async {
      final news = fakeNews();

      when(
        () => box.get(CacheConstants.keySavedNews, defaultValue: []),
      ).thenReturn([news.toMap()]);
      when(
        () => box.put(CacheConstants.keySavedNews, any()),
      ).thenAnswer((_) async => {});

      await newsLocalDataSource.removeNews(news);

      verify(
        () => box.get(CacheConstants.keySavedNews, defaultValue: []),
      ).called(1);

      verify(() => box.put(CacheConstants.keySavedNews, [])).called(1);
    },
  );

  test(
    'getIsSaved | lokalde kayıtlı olan haberi var mı diye kontrol ediyoruz -> true döner',
    () {
      final news = fakeNews();
      when(
        () => box.get(CacheConstants.keySavedNews),
      ).thenReturn([news.toMap()]);
      final result = newsLocalDataSource.getIsSaved(news);
      expect(result, isTrue);
    },
  );

  test(
    'getIsSaved | lokalde kayıtlı olmayan bir haberi var mı diye kontrol ediyoruz -> false döner',
    () {
      final news = fakeNews();
      when(() => box.get(CacheConstants.keySavedNews)).thenReturn([]);
      final result = newsLocalDataSource.getIsSaved(news);
      expect(result, isFalse);
    },
  );

  test(
    'getSavedNewsList | lokalde kayıtlı olan haberleri döner -> List<NewsModel>',
    () {
      final news = fakeNews();
      when(
        () => box.get(CacheConstants.keySavedNews, defaultValue: []),
      ).thenReturn([news.toMap()]);
      final result = newsLocalDataSource.getSavedNewsList();
      expect(result, isA<List<NewsModel>>());
    },
  );
}
