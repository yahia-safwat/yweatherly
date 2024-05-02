import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../errors/exceptions.dart';
import 'clients/api_client.dart';
import 'clients/dio_client.dart';
import 'clients/http_client.dart';

/// Extracts and returns JSON data from the API response based on the API client type.
/// Throws a [ServerException] if the API client type is not supported.
Map<String, dynamic> extractJsonData(ApiClient apiClient, dynamic response) {
  if (apiClient is ApiHttpClient) {
    // If the API client is HttpClient, decode the response body as JSON
    return json.decode((response as http.Response).body);
  } else if (apiClient is ApiDioClient) {
    // If the API client is DioClient, decode the response data as JSON
    return (response as Response).data;
  } else {
    // Throw an exception for unsupported API client type
    throw ServerException('Unsupported API client type: $apiClient');
  }
}
