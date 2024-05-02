import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:yweatherly/core/errors/exceptions.dart';
import 'package:yweatherly/features/weather/data/data_sources/remote_data_source.dart';
import 'package:yweatherly/features/weather/data/models/weather_model.dart';
import 'package:yweatherly/core/services/api/api_endpoints.dart';
import '../../../../helpers/utils/test_helper.mocks.dart';
import '../../../../helpers/utils/test_utils.dart';

void main() {
  late MockApiDioClient mockApiDioClient;
  late MockApiHttpClient mockApiHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSource;

  setUp(() {
    mockApiDioClient = MockApiDioClient();
    mockApiHttpClient = MockApiHttpClient();
    weatherRemoteDataSource =
        WeatherRemoteDataSourceImpl(apiClient: mockApiHttpClient);
  });

  group('getCurrentWeather', () {
    test(
        'should return WeatherModel when the response code is 200 with ApiHttpClient',
        () async {
      // Arrange
      const cityName = 'London';
      final expectedUrl = ApiEndpoints.openWeatherMapCurrentWeather(cityName);

      // Stub the behavior of ApiHttpClient's get method to return a successful response
      when(mockApiHttpClient.get(expectedUrl))
          .thenAnswer((_) async => http.Response(
                readJson('helpers/dummy/dummy_weather_response.json'),
                200,
              ));

      // Act
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);

      // Assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw a server exception when the response code is not 200 with ApiHttpClient',
      () async {
        // Arrange
        const cityName = 'New York';
        final expectedUrl = ApiEndpoints.openWeatherMapCurrentWeather(cityName);

        // Stub the behavior of ApiHttpClient's get method to return a failure response (e.g., status code 404)
        when(mockApiHttpClient.get(expectedUrl))
            .thenAnswer((_) async => http.Response('Not found', 404));

        // Act
        weatherRemoteDataSource =
            WeatherRemoteDataSourceImpl(apiClient: mockApiHttpClient);
        final result = weatherRemoteDataSource.getCurrentWeather(cityName);

        // Assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );

    test(
        'should return WeatherModel when the response code is 200 with ApiDioClient',
        () async {
      // Arrange
      const cityName = 'London';
      final expectedUrl = ApiEndpoints.openWeatherMapCurrentWeather(cityName);

      // Stub the behavior of ApiDioClient's get method to return a successful response
      // with JSON data by converting the JSON [string] to a [map] using json.decode.
      when(mockApiDioClient.get(expectedUrl)).thenAnswer((_) async => Response(
            requestOptions: RequestOptions(path: expectedUrl),
            statusCode: 200,
            data: json
                .decode(readJson('helpers/dummy/dummy_weather_response.json')),
          ));

      // Act
      weatherRemoteDataSource =
          WeatherRemoteDataSourceImpl(apiClient: mockApiDioClient);
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);

      // Assert
      expect(result, isA<WeatherModel>());
    });

    test(
      'should throw a server exception when the response code is not 200 with ApiDioClient',
      () async {
        // Arrange
        const cityName = 'New York';
        final expectedUrl = ApiEndpoints.openWeatherMapCurrentWeather(cityName);

        // Stub the behavior of ApiDioClient's get method to return a failure response (e.g., status code 404)
        when(mockApiDioClient.get(expectedUrl))
            .thenAnswer((_) async => Response(
                  requestOptions: RequestOptions(path: expectedUrl),
                  statusCode: 404,
                ));

        // Act
        weatherRemoteDataSource =
            WeatherRemoteDataSourceImpl(apiClient: mockApiDioClient);
        final result = weatherRemoteDataSource.getCurrentWeather(cityName);

        // Assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
