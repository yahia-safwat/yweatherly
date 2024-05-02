import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:yweatherly/features/weather/data/models/weather_model.dart';
import 'package:yweatherly/features/weather/domain/entities/weather.dart';

import '../../../../helpers/utils/test_utils.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test('should be a subclass of wather entity', () {
    // expect
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("should return a valid model from json", () {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson('helpers/dummy/dummy_weather_response.json'));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, isA<WeatherModel>());
  });

  test("should return a json map containing proper data", () {
    // arrange
    // act
    final result = testWeatherModel.toJson();

    // assert
    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        }
      ],
      'main': {
        'temp': 292.87,
        'pressure': 1012,
        'humidity': 70,
      },
      'name': 'New York',
    };
    expect(result, expectedJsonMap);
  });
}
