import 'package:flutter_news_app/core/constants/enums.dart';
import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String get formattedDate {
    final DateFormat formatter = DateFormat('MM.dd.yyyy HH:mm');
    return formatter.format(this);
  }
}

extension NewsCategoryExtension on NEWS_CATEGORY {
  String get name {
    switch (this) {
      case NEWS_CATEGORY.ALL:
        return "All";
      case NEWS_CATEGORY.SPORTS:
        return "Sports";
      case NEWS_CATEGORY.HEALTH:
        return "Health";
      case NEWS_CATEGORY.SCIENCE:
        return "Science";
      case NEWS_CATEGORY.TECHNOLOGY:
        return "Technology";
      case NEWS_CATEGORY.BUSINESS:
        return "Business";
      case NEWS_CATEGORY.ENTERTAINMENT:
        return "Entertainment";
    }
  }

  String get apiName {
    switch (this) {
      case NEWS_CATEGORY.ALL:
        return "all";
      case NEWS_CATEGORY.SPORTS:
        return "sports";
      case NEWS_CATEGORY.HEALTH:
        return "health";
      case NEWS_CATEGORY.SCIENCE:
        return "science";
      case NEWS_CATEGORY.TECHNOLOGY:
        return "technology";
      case NEWS_CATEGORY.BUSINESS:
        return "business";
      case NEWS_CATEGORY.ENTERTAINMENT:
        return "entertainment";
    }
  }
}
