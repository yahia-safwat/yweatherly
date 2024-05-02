import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'features/weather/presentation/pages/weather_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<WeatherBloc>(),
        )
      ],
      child: const MaterialApp(
        home: WeatherPage(),
      ),
    );
  }
}
