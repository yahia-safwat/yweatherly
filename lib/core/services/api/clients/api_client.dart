import 'dart:async';

/// Abstract class for consuming APIs.
abstract class ApiClient {
  /// Performs a GET request.
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});

  /// Performs a POST request.
  Future<dynamic> post(String url, {Map<String, dynamic>? data});

  /// Performs a PUT request.
  Future<dynamic> put(String url, {Map<String, dynamic>? data});

  /// Performs a DELETE request.
  Future<dynamic> delete(String url);
}
