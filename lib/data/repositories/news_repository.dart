import 'package:flutter_news_app/data/models/news_model.dart';
import 'package:flutter_news_app/data/models/news_response_model.dart';
import 'package:flutter_news_app/data/datasources/remote/news_api_service.dart';
import 'package:flutter_news_app/core/util/helper.dart';

abstract class NewsRepository {
  Future<List<NewsModel>> getTopHeadlines({String? category, int? pageSize});

  Future<List<NewsModel>> getSearchNews({required String searchString});
}

class NewsRepositoryImpl extends NewsRepository {
  final NewsApiService _newsApiService;

  NewsRepositoryImpl(this._newsApiService);

  @override
  Future<List<NewsModel>> getTopHeadlines({
    String? category,
    int? pageSize,
  }) async {
    var response = await _newsApiService.getTopHeadlines(
      category: category,
      pageSize: pageSize,
    );
    return Helper.handleResponse(response, NewsResponseModel.decoder);
  }

  @override
  Future<List<NewsModel>> getSearchNews({required String searchString}) async {
    var response = await _newsApiService.getSearchNews(
      searchString: searchString,
    );
    return Helper.handleResponse(response, NewsResponseModel.decoder);
  }
}
