import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_news_app/core/constants/string_constants.dart';
import 'package:flutter_news_app/core/errors/exceptions.dart';
import 'package:logging/logging.dart';

class Helper {
  static final _logger = Logger('Helper');

  static dynamic handleResponse(
    dio.Response<dynamic> response,
    Function(dynamic) decoder,
  ) {
    try {
      switch (response.statusCode) {
        case HttpStatus.ok:
          if (response.data != null) {
            if (response.data.isEmpty) {
              _logger.warning('Empty response');
              throw EmptyResponseException(StringConstants.EMPTY_RESPONSE);
            } else {
              return decoder(response.data);
            }
          } else {
            _logger.warning('Null response data');
            throw EmptyResponseException(StringConstants.EMPTY_RESPONSE);
          }
        case HttpStatus.badRequest:
          _logger.warning('Bad request: ${response.data}');
          throw BadRequestException(StringConstants.BAD_REQUEST_ERROR);
        case HttpStatus.internalServerError:
          _logger.severe('Server error: ${response.data}');
          throw ServerException(StringConstants.SERVER_ERROR);
        case HttpStatus.requestTimeout:
        case HttpStatus.gatewayTimeout:
          _logger.warning('Request timed out');
          throw RequestTimeoutException(StringConstants.TIMEOUT_ERROR);
        default:
          _logger.severe('Unhandled status code: ${response.statusCode}');
          throw DefaultApiException(StringConstants.DEFAULT_ERROR_MESSAGE);
      }
    } catch (e, st) {
      _logger.severe('Error handling response', e, st);
      rethrow;
    }
  }

  static bool handleTokenExpiredControl(dynamic error) {
    final message = error.toString();
    return message.contains('user-token-expired');
  }

  static String getFriendlyErrorMessage(dynamic error) {
    try {
      // 1) Typed API exceptions produced by handleResponse
      if (error is ApiException) return error.message;

      // 2) Dio/DioException errors
      if (error is dio.DioException) {
        final response = error.response;
        final status = response?.statusCode;
        if (status != null) {
          switch (status) {
            case HttpStatus.badRequest:
              return StringConstants.BAD_REQUEST_ERROR;
            case HttpStatus.internalServerError:
              return StringConstants.SERVER_ERROR;
            case HttpStatus.requestTimeout:
            case HttpStatus.gatewayTimeout:
              return StringConstants.TIMEOUT_ERROR;
            default:
              return StringConstants.DEFAULT_ERROR_MESSAGE;
          }
        }

        // Map DioException types (timeouts, connectivity, etc.)
        final type = error.type;
        if (type == dio.DioExceptionType.connectionTimeout ||
            type == dio.DioExceptionType.sendTimeout ||
            type == dio.DioExceptionType.receiveTimeout) {
          return StringConstants.TIMEOUT_ERROR;
        }
        return StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE;
      }

      // 3) Socket errors
      if (error is SocketException) {
        return StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE;
      }

      // 4) Firebase / Auth style error code text mapping
      final message = error.toString();
      if (message.contains('invalid-email') ||
          message.contains('user-disabled') ||
          message.contains('user-not-found') ||
          message.contains('wrong-password') ||
          message.contains('email-already-in-use') ||
          message.contains('operation-not-allowed') ||
          message.contains('weak-password') ||
          message.contains('too-many-requests') ||
          message.contains('missing-email') ||
          message.contains('internal-error') ||
          message.contains('invalid-credential') ||
          message.contains('account-exists-with-different-credential') ||
          message.contains('invalid-verification-code') ||
          message.contains('invalid-verification-id') ||
          message.contains('user-token-expired')) {
        // reuse earlier mapping logic but keep it local so Helper remains the single public API
        if (message.contains('invalid-email')) {
          return StringConstants.INVALID_EMAIL_ERROR_MESSAGE;
        } else if (message.contains('user-disabled')) {
          return StringConstants.USER_DISABLED_ERROR_MESSAGE;
        } else if (message.contains('user-not-found')) {
          return StringConstants.USER_MAIL_NOT_FOUND_ERROR_MESSAGE;
        } else if (message.contains('wrong-password')) {
          return StringConstants.WRONG_PASSWORD_ERROR_MESSAGE;
        } else if (message.contains('email-already-in-use')) {
          return StringConstants.EMAIL_ALREADY_IN_USE_ERROR_MESSAGE;
        } else if (message.contains('operation-not-allowed')) {
          return StringConstants.OPERATION_NOT_ALLOWED_ERROR_MESSAGE;
        } else if (message.contains('weak-password')) {
          return StringConstants.WEAK_PASSWORD_ERROR_MESSAGE;
        } else if (message.contains('too-many-requests')) {
          return StringConstants.TOO_MANY_REQUESTS_ERROR_MESSAGE;
        } else if (message.contains('network-request-failed')) {
          return StringConstants.NETWORK_REQUEST_FAILED_ERROR_MESSAGE;
        } else if (message.contains('missing-email')) {
          return StringConstants.MISSING_EMAIL_ERROR_MESSAGE;
        } else if (message.contains('internal-error')) {
          return StringConstants.INTERNAL_ERROR_MESSAGE;
        } else if (message.contains('invalid-credential')) {
          return StringConstants.INVALID_CREDENTIAL_ERROR_MESSAGE;
        } else if (message.contains(
          'account-exists-with-different-credential',
        )) {
          return StringConstants
              .ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL_ERROR_MESSAGE;
        } else if (message.contains('invalid-verification-code')) {
          return StringConstants.INVALID_VERIFICATION_CODE_ERROR_MESSAGE;
        } else if (message.contains('invalid-verification-id')) {
          return StringConstants.INVALID_VERIFICATION_ID_ERROR_MESSAGE;
        } else if (message.contains('user-token-expired')) {
          return StringConstants.USER_NOT_FOUND_ERROR_MESSAGE;
        }
      }

      // Final fallback: return message if present or the default user message
      return message.isNotEmpty
          ? message
          : StringConstants.DEFAULT_ERROR_MESSAGE;
    } catch (e, st) {
      _logger.severe('Failed to map friendly error message', e, st);
      return StringConstants.DEFAULT_ERROR_MESSAGE;
    }
  }
}
