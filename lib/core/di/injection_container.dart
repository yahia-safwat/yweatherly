import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yweatherly/features/weather/domain/usecases/get_current_weather.dart';

import '../../features/weather/data/data_sources/remote_data_source.dart';
import '../../features/weather/data/repositories/weather_repository_impl.dart';
import '../../features/weather/domain/repositories/weather_repository.dart';
import '../../features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import '../enums/client_type.dart';
import '../services/api/clients/api_client.dart';
import '../services/api/clients/dio_client.dart';
import '../services/api/clients/http_client.dart';

//! Service Locator Setup
const apiClient = ApiClientType.http; // Specify the type of API client

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! Features - Weather
  // Bloc
  sl.registerFactory(
    () => WeatherBloc(getCurrentWeatherUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeatherUseCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiClient: sl()),
  );

  // API client:
  sl.registerLazySingleton<ApiClient>(() => determineApiClient(apiClient));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

//! Helper Functions
// Function to determine the API client based on the provided type
ApiClient determineApiClient(ApiClientType type) {
  switch (type) {
    case ApiClientType.http:
      sl.registerLazySingleton(() => http.Client());
      return ApiHttpClient(sl());
    case ApiClientType.dio:
      sl.registerLazySingleton(() => Dio());
      return ApiDioClient(sl());
    // Handle additional types if needed
    default:
      throw ArgumentError('Invalid API client type: $type');
  }
}
