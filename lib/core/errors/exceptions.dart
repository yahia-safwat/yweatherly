/// Exception representing errors related to server communication.
class ServerException implements Exception {
  final String? message;
  ServerException([this.message]);
}

/// Exception representing errors related to caching data.
class CacheException implements Exception {}

/// Exception representing errors related to network connectivity.
class NetworkException implements Exception {}
