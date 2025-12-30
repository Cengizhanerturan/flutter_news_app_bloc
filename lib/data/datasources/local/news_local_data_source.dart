import 'package:flutter_news_app/core/constants/cache_constants.dart';
import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewsLocalDataSource {
  final Box _box;

  NewsLocalDataSource(this._box);

  Future<void> saveNews(NewsModel news) async {
    var currentList = getSavedNewsList();
    currentList.add(news);
    return await _box.put(
      CacheConstants.keySavedNews,
      currentList.map((news) => news.toMap()).toList(),
    );
  }

  Future<void> removeNews(NewsModel news) async {
    var currentList = getSavedNewsList();
    currentList.remove(news);
    await _box.put(
      CacheConstants.keySavedNews,
      currentList.map((news) => news.toMap()).toList(),
    );
  }

  bool getIsSaved(NewsModel newsModel) {
    var data = _box.get(CacheConstants.keySavedNews);
    if (data == null) {
      return false;
    } else {
      var savedNewsList = NewsModel.decoder(data);
      return savedNewsList.contains(newsModel);
    }
  }

  List<NewsModel> getSavedNewsList() {
    final savedNewsList = _box.get(
      CacheConstants.keySavedNews,
      defaultValue: [],
    );
    return NewsModel.decoder(savedNewsList);
  }
}
