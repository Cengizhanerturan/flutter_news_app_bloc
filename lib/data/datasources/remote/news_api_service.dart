import 'package:dio/dio.dart' as dio;
import 'package:flutter_news_app/core/constants/api_constants.dart';
import 'package:flutter_news_app/core/network/api_client.dart';

class NewsApiService {
  final ApiClient client;

  NewsApiService(this.client);

  Future<dio.Response> getTopHeadlines({
    String? category,
    int? pageSize,
  }) async {
    var param = {
      'country': ApiConstants.DEFAULT_COUNTRY,
      'pageSize': pageSize ?? ApiConstants.DEFAULT_PAGE_SIZE,
    };

    if (category != null) {
      param['category'] = category;
    }

    var response = await client.get('top-headlines', queryParameters: param);
    return response;
  }

  Future<dio.Response> getSearchNews({required String searchString}) async {
    return client.get('everything', queryParameters: {'q': searchString});
  }
}
