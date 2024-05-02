import 'package:yweatherly/core/services/api/api_endpoints.dart';
import 'package:yweatherly/features/weather/data/models/weather_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/api/api_functions.dart';
import '../../../../core/services/api/clients/api_client.dart';

/// Abstraction for fetching weather data from a remote data source.
abstract class WeatherRemoteDataSource {
  /// Fetches the current weather data for the specified city from the OpenWeatherMap API.
  ///
  /// Throws a [ServerException] if unable to fetch the data.
  Future<WeatherModel> getCurrentWeather(String cityName);
}

/// Implementation of [WeatherRemoteDataSource] using an [ApiClient] for network operations.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiClient apiClient;

  WeatherRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await apiClient
        .get(ApiEndpoints.openWeatherMapCurrentWeather(cityName));

    if (response.statusCode == 200) {
      final jsonData = extractJsonData(apiClient, response);
      return WeatherModel.fromJson(jsonData);
    } else {
      throw ServerException();
    }
  }
}
