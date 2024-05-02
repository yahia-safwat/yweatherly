import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/transformers/bloc_transformers.dart';
import '../../../domain/entities/weather.dart';
import '../../../domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc({required this.getCurrentWeatherUseCase})
      : super(WeatherInitial()) {
    // Using rxdart's debounce functionality to debounce the OnCityChanged events
    on<OnCityChanged>(_handleCityChanged, transformer: _debounceTransformer);
  }

  /// Handles the OnCityChanged event.
  void _handleCityChanged(
    OnCityChanged event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());
    final result = await getCurrentWeatherUseCase(event.cityName);
    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  /// Event transformer for debouncing the [OnCityChanged] events, ensuring only the last event within 500 milliseconds is processed.
  /// Helps reduce unnecessary API calls triggered by rapid user interactions.
  static EventTransformer<OnCityChanged> get _debounceTransformer =>
      debounce(const Duration(milliseconds: 1000));
}
