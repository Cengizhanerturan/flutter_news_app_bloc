import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String BASE_URL = 'https://newsapi.org/v2/';
  static String get API_KEY => dotenv.env['API_KEY'] ?? '';
  static const String DEFAULT_COUNTRY = 'us';

  static const int DEFAULT_PAGE_SIZE = 20;
  static const int DEFAULT_SLIDER_PAGE_SIZE = 5;
}
