import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:yweatherly/core/errors/failures.dart';

import 'package:yweatherly/features/weather/domain/entities/weather.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(message: 'An error has occurred'));
    } on SocketException {
      return const Left(NetworkFailure(message: 'No internet connection'));
    }
  }
}
