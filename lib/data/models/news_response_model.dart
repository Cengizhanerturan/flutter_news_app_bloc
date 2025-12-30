import 'dart:convert';
import 'package:flutter_news_app/data/models/news_model.dart';

class NewsResponseModel {
  final String status;
  final int totalResults;
  final List<NewsModel> newsModelList;

  NewsResponseModel({
    required this.status,
    required this.totalResults,
    required this.newsModelList,
  });

  factory NewsResponseModel.fromMap(Map<String, dynamic> json) =>
      NewsResponseModel(
        status: json["status"],
        totalResults: json["totalResults"],
        newsModelList: List<NewsModel>.from(
          json["articles"].map((x) => NewsModel.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(newsModelList.map((x) => x.toMap())),
  };

  static List<NewsModel> decoder(dynamic data) {
    try {
      if (data is String) {
        var json = jsonDecode(data);
        var newsResponseModel = NewsResponseModel.fromMap(json);
        newsResponseModel.newsModelList.removeWhere(
          (news) => news.title == '[Removed]' || news.urlToImage.isEmpty,
        );
        return newsResponseModel.newsModelList;
      } else if (data is Map<String, dynamic>) {
        var newsResponseModel = NewsResponseModel.fromMap(data);
        newsResponseModel.newsModelList.removeWhere(
          (news) => news.title == '[Removed]' || news.urlToImage.isEmpty,
        );
        return newsResponseModel.newsModelList;
      } else {
        throw Exception("Invalid data type");
      }
    } catch (e) {
      rethrow;
    }
  }
}
