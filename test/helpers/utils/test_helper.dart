import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:yweatherly/core/services/api/clients/dio_client.dart';
import 'package:yweatherly/core/services/api/clients/http_client.dart';
import 'package:yweatherly/features/weather/data/data_sources/remote_data_source.dart';
import 'package:yweatherly/features/weather/domain/repositories/weather_repository.dart';
import 'package:yweatherly/features/weather/domain/usecases/get_current_weather.dart';

/// # Run the following command in the terminal to generate the mock classes
/// $ [dart run build_runner build]

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
    ApiHttpClient,
    ApiDioClient,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
