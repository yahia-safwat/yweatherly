import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yweatherly/features/weather/domain/entities/weather.dart';
import 'package:yweatherly/features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'package:yweatherly/features/weather/presentation/pages/weather_page.dart';

import '../../../../helpers/utils/test_utils.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;
  });

  /// Helper function to create a testable widget with a [WeatherBloc].
  /// It Wraps the provided [body] widget with a [BlocProvider] containing a [WeatherBloc] instance.
  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  testWidgets(
    'Entering text in the TextField should trigger state change from initial to loading',
    (tester) async {
      // Arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherInitial());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WeatherPage()));
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await tester.enterText(textField, 'New York');
      await tester.pump();

      // Assert
      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    'Progress indicator should be shown when state is loading',
    (tester) async {
      // Arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      // Act
      await tester.pumpWidget(makeTestableWidget(const WeatherPage()));
      await tester
          .pump(); // Pump the widget to start animations and schedule microtasks
      await tester.pump(const Duration(seconds: 1)); // Wait for 1 second

      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Widget should display weather data when state is WeatherLoaded',
    (tester) async {
      // Arrange
      when(() => mockWeatherBloc.state)
          .thenReturn(const WeatherLoaded(testWeather));

      // Act
      await tester.pumpWidget(makeTestableWidget(const WeatherPage()));
      await tester
          .pumpAndSettle(); // Ensure all asynchronous operations are completed

      // Assert
      expect(find.byKey(const Key('weather_data')), findsOneWidget);
    },
  );

  tearDownCommon(); // Common teardown logic
}
