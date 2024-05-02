import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_client.dart';

/// API service using Http for network operations.
class ApiHttpClient extends ApiClient {
  final http.Client _httpClient;

  ApiHttpClient(this._httpClient);

  /// Perform a GET request.
  @override
  Future<http.Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    return response;
  }

  /// Perform a POST request.
  @override
  Future<http.Response> post(String url, {Map<String, dynamic>? data}) async {
    final response = await _httpClient
        .post(Uri.parse(url), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }

  /// Perform a PUT request.
  @override
  Future<http.Response> put(String url, {Map<String, dynamic>? data}) async {
    final response = await _httpClient
        .put(Uri.parse(url), body: json.encode(data), headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }

  /// Perform a DELETE request.
  @override
  Future<http.Response> delete(String url) async {
    final response = await _httpClient.delete(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });
    return response;
  }
}
