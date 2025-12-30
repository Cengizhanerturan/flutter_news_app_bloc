import 'package:dio/dio.dart';
import 'package:flutter_news_app/core/constants/api_constants.dart';
import 'package:flutter_news_app/core/network/api_exception.dart';
import 'package:logging/logging.dart';

abstract class ApiClient {
  Dio get dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future<Response<dynamic>> post(String path, {dynamic data});
  Future<Response<dynamic>> put(String path, {dynamic data});
  Future<Response<dynamic>> patch(String path, {dynamic data});
  Future<Response<dynamic>> delete(String path, {dynamic data});
}

class ApiClientImpl implements ApiClient {
  @override
  final Dio dio;
  final Logger _logger = Logger('ApiClient');

  ApiClientImpl({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: const String.fromEnvironment(
                'API_BASE_URL',
                defaultValue: ApiConstants.BASE_URL,
              ),
              headers: <String, dynamic>{
                'Accept': 'application/json',
                'Content-Type': 'application/json; charset=utf-8',
              },
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 20),
              sendTimeout: const Duration(seconds: 20),
            ),
          ) {
    this.dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => _logger.fine(obj),
      ),
    );

    this.dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final status = response.statusCode ?? 0;
          if (status < 200 || status >= 300) {
            handler.reject(
              DioException.badResponse(
                statusCode: status,
                requestOptions: response.requestOptions,
                response: response,
              ),
            );
            return;
          }
          handler.next(response);
        },
      ),
    );
  }

  T _wrapAndRethrow<T>(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      final message =
          error.response?.data is Map<String, dynamic>
              ? ((error.response!.data['message'] ?? error.message)
                      as String? ??
                  'Network error')
              : (error.message ?? 'Network error');
      throw ApiException(statusCode: status, message: message);
    }
    throw ApiException(message: error.toString());
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      if (queryParameters != null) {
        queryParameters['apiKey'] = ApiConstants.API_KEY;
      }
      return await dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      return _wrapAndRethrow<Response<dynamic>>(e);
    }
  }

  @override
  Future<Response<dynamic>> post(String path, {dynamic data}) async {
    try {
      return await dio.post(path, data: data);
    } catch (e) {
      return _wrapAndRethrow<Response<dynamic>>(e);
    }
  }

  @override
  Future<Response<dynamic>> put(String path, {dynamic data}) async {
    try {
      return await dio.put(path, data: data);
    } catch (e) {
      return _wrapAndRethrow<Response<dynamic>>(e);
    }
  }

  @override
  Future<Response<dynamic>> patch(String path, {dynamic data}) async {
    try {
      return await dio.patch(path, data: data);
    } catch (e) {
      return _wrapAndRethrow<Response<dynamic>>(e);
    }
  }

  @override
  Future<Response<dynamic>> delete(String path, {dynamic data}) async {
    try {
      return await dio.delete(path, data: data);
    } catch (e) {
      return _wrapAndRethrow<Response<dynamic>>(e);
    }
  }
}
