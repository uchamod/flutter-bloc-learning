import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repositories/location_provider.dart';
import 'package:weather_app/data/repositories/weather_repositort_impl.dart';
import 'package:weather_app/domain/repositories/weather_repostory.dart';
import 'package:weather_app/presentation/bloc/search/search_bloc.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/pages/main_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create:
          (context) => WeatherRepostory(
            weatherDataProvider: WeatherDataProvider(),
            locationProvider: LocationProvider(),
          ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherBloc(context.read<WeatherRepostory>()),
          ),
          BlocProvider(
            create: (context) => SearchBloc(context.read<WeatherRepostory>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(brightness: Brightness.dark),
          home: const MainWrapper(),
        ),
      ),
    );
  }
}
