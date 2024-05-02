import 'package:dio/dio.dart';

import 'api_client.dart';

/// API service using Dio for network operations.
class ApiDioClient extends ApiClient {
  final Dio _dio;

  ApiDioClient(this._dio);

  /// Performs a GET request.
  @override
  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    final Response<dynamic> response =
        await _dio.get(url, queryParameters: queryParameters);
    return response;
  }

  /// Performs a POST request.
  @override
  Future<Response<dynamic>> post(String url,
      {Map<String, dynamic>? data}) async {
    final Response<dynamic> response = await _dio.post(url, data: data);
    return response;
  }

  /// Performs a PUT request.
  @override
  Future<Response<dynamic>> put(String url,
      {Map<String, dynamic>? data}) async {
    final Response<dynamic> response = await _dio.put(url, data: data);
    return response;
  }

  /// Performs a DELETE request.
  @override
  Future<Response<dynamic>> delete(String url) async {
    final Response<dynamic> response = await _dio.delete(url);
    return response;
  }
}
