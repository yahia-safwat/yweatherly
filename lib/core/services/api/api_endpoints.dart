import 'package:yweatherly/core/services/api/api_constanst.dart';

class ApiEndpoints {
  // Public [endpoints] using private functions: --------------

  /// Endpoint for fetching current weather data by city name from the OpenWeatherMap API.
  static String openWeatherMapCurrentWeather(String city) =>
      _openWeatherMapCurrentWeatherUrl(city);

  /// Endpoint for fetching a weather icon by icon code from the OpenWeatherMap API.
  static String openWeatherMapWeatherIcon(String iconCode) =>
      _openWeatherMapWeatherIconUrl(iconCode);

  // Add more endpoints as needed

  // Private [functions] for constructing URLs: --------------

  /// Constructs the URL for fetching current weather data by city name from the OpenWeatherMap API.
  static String _openWeatherMapCurrentWeatherUrl(String city) =>
      '${ApiConstants.openWeatherMapBaseUrl}/weather?q=$city&appid=${ApiConstants.openWeatherMapApiKey}';

  /// Constructs the URL for fetching a weather icon by icon code from the OpenWeatherMap API.
  static String _openWeatherMapWeatherIconUrl(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
