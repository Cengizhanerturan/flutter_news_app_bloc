import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fromMap doğru çalışmalı', () {
    final json = {
      "source": {"id": "bbc", "name": "BBC"},
      "author": "Author",
      "title": "Title",
      "description": "Desc",
      "url": "https://test.com",
      "urlToImage": "img",
      "publishedAt": "2024-01-01T00:00:00Z",
      "content": "Content",
    };

    final model = NewsModel.fromMap(json);

    expect(model.title, "Title");
    expect(model.source.name, "BBC");
  });

  test('decoder dogru çalışmalı', () {
    final mockNews = {
      "source": {"id": "bbc", "name": "BBC"},
      "author": "Author",
      "title": "Title",
      "description": "Desc",
      "url": "https://test.com",
      "urlToImage": "img",
      "publishedAt": "2024-01-01T00:00:00Z",
      "content": "Content",
    };
    final data = List.generate(10, (i) => mockNews);
    final decoder = NewsModel.decoder(data);

    expect(decoder.length, 10);
    expect(decoder.first.title, "Title");
    expect(decoder.last.title, "Title");
    expect(decoder, isA<List<NewsModel>>());
  });
}
