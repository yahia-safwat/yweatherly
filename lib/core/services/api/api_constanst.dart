class ApiConstants {
  // [OpenWeatherMap API]:------------------------------------
  // Base URL for OpenWeatherMap API endpoints
  static const String openWeatherMapBaseUrl =
      'https://api.openweathermap.org/data/2.5';
  // API Key for OpenWeatherMap authentication
  static const String openWeatherMapApiKey = 'cc95d932d5a45d33a9527d5019475f2c';

  // [WorldWeather API]:------------------------------------
  // Base URL for WorldWeather API endpoints
  static const String worldWeatherApiBaseUrl = 'https://api.worldweather.com';
  // API Key for WorldWeather authentication
  static const String worldWeatherApiKey = 'your_worldweather_api_key';

  // [Common constants]: ------------------------------------
  // Timeout duration for API requests (in milliseconds)
  static const int timeoutDuration = 5000;
  // Content type for request headers
  static const String contentType = 'application/json';
  // Header for authentication token
  static const String authHeader = 'Authorization';
  // Prefix for bearer token in authentication header
  static const String bearerTokenPrefix = 'Bearer';
  // Error messages for API requests
  static const String connectionErrorMessage =
      'Failed to connect to the server. Please check your internet connection.';
  static const String timeoutErrorMessage =
      'The request timed out. Please try again later.';
  static const String unknownErrorMessage =
      'An unknown error occurred. Please try again later.';
}
