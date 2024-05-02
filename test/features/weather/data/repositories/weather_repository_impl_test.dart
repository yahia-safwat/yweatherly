import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yweatherly/core/errors/exceptions.dart';
import 'package:yweatherly/core/errors/failures.dart';
import 'package:yweatherly/features/weather/data/models/weather_model.dart';
import 'package:yweatherly/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:yweatherly/features/weather/domain/entities/weather.dart';

import '../../../../helpers/utils/test_helper.mocks.dart';

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepositoryImpl(weatherRemoteDataSource: mockDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const cityName = 'New York';

  group('WeatherRepositoryImpl', () {
    group('getCurrentWeather', () {
      test(
        'should return WeatherEntity when the data source returns a valid response',
        () async {
          // Arrange
          when(mockDataSource.getCurrentWeather(cityName))
              .thenAnswer((_) async => testWeatherModel);

          // Act
          final result = await repository.getCurrentWeather(cityName);

          // Assert
          expect(result, const Right(testWeatherEntity));
          verify(mockDataSource.getCurrentWeather(cityName)).called(1);
        },
      );

      test(
        'should return ServerFailure when the data source throws a ServerException',
        () async {
          // Arrange
          when(mockDataSource.getCurrentWeather(cityName))
              .thenThrow(ServerException());

          // Act
          final result = await repository.getCurrentWeather(cityName);

          // Assert
          expect(result,
              const Left(ServerFailure(message: 'An error has occurred')));
          verify(mockDataSource.getCurrentWeather(cityName)).called(1);
        },
      );

      test(
        'should return NetworkFailure when the data source throws a SocketException',
        () async {
          // Arrange
          when(mockDataSource.getCurrentWeather(any))
              .thenThrow(const SocketException(''));

          // Act
          final result = await repository.getCurrentWeather(cityName);

          // Assert
          expect(result,
              const Left(NetworkFailure(message: 'No internet connection')));
          verify(mockDataSource.getCurrentWeather(cityName)).called(1);
        },
      );
    });
  });
}
