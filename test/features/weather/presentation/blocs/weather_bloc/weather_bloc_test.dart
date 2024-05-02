import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:yweatherly/core/errors/failures.dart';
import 'package:yweatherly/features/weather/domain/entities/weather.dart';
import 'package:yweatherly/features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';

import '../../../../../helpers/utils/test_helper.mocks.dart';

void main() {
  late WeatherBloc weatherBloc;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc =
        WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
  });

  const cityName = 'New York';

  const testWeather = WeatherEntity(
    cityName: cityName,
    main: 'Clear',
    description: 'Clear sky',
    iconCode: '01d',
    temperature: 22.0,
    pressure: 1010,
    humidity: 60,
  );

  test('initial state should be WeatherInitial', () {
    // Arrange & Act
    final initialState = weatherBloc.state;
    // Assert
    expect(initialState, equals(WeatherInitial()));
  });

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] states when GetCurrentWeatherUseCase returns WeatherEntity',
    build: () {
      when(mockGetCurrentWeatherUseCase(cityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 1000),
    expect: () => [WeatherLoading(), const WeatherLoaded(testWeather)],
  );

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherError] states when GetCurrentWeatherUseCase returns a Failure',
    build: () {
      const errorMessage = 'Failed to fetch weather';
      const failure = ServerFailure(message: errorMessage);
      when(mockGetCurrentWeatherUseCase(cityName))
          .thenAnswer((_) async => const Left(failure));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(cityName)),
    wait: const Duration(milliseconds: 1000),
    expect: () =>
        [WeatherLoading(), const WeatherError('Failed to fetch weather')],
  );
}
