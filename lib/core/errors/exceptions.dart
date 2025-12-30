class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class BadRequestException extends ApiException {
  BadRequestException(super.message);
}

class ServerException extends ApiException {
  ServerException(super.message);
}

class RequestTimeoutException extends ApiException {
  RequestTimeoutException(super.message);
}

class EmptyResponseException extends ApiException {
  EmptyResponseException(super.message);
}

class DefaultApiException extends ApiException {
  DefaultApiException(super.message);
}
