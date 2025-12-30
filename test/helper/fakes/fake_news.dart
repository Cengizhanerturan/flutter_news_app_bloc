import 'package:flutter_news_app/data/models/news_model.dart';

NewsModel fakeNews([int? index]) {
  return NewsModel(
    source: Source(id: 'cnn', name: 'CNN'),
    author: 'Matt Egan',
    title: index != null ? 'title $index' : 'title',
    description: 'description',
    url: 'url',
    urlToImage: 'urlToImage',
    publishedAt: DateTime.now(),
    content: 'content',
  );
}
