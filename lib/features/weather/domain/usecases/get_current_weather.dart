import 'package:dartz/dartz.dart';
import 'package:yweatherly/core/errors/failures.dart';
import 'package:yweatherly/features/weather/domain/entities/weather.dart';
import 'package:yweatherly/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
