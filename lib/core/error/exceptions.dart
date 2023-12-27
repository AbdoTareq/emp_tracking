class ServerException implements Exception {
  final String? message;

  ServerException({this.message});
}

class RequestException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}


