// lib/core/network/network_exceptions.dart
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ServerException extends NetworkException {
  ServerException([String message = 'Server error occurred'])
      : super(message, 500);
}

class CacheException extends NetworkException {
  CacheException([super.message = 'Cache error occurred']);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException([String message = 'Unauthorized'])
      : super(message, 401);
}

class NotFoundException extends NetworkException {
  NotFoundException([String message = 'Resource not found'])
      : super(message, 404);
}