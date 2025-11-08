import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/data/repos/weather_repostory.dart';
import 'package:weather_app/presentation/pages/home_screen.dart';

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
          (context) =>
              WeatherRepostory(weatherDataProvider: WeatherDataProvider()),
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepostory>()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(brightness: Brightness.dark),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
