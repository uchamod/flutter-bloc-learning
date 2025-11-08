import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/main_weather_section.dart';
import 'package:weather_app/presentation/widgets/weather_info_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchedWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is WeatherFailedState) {
            return Center(child: Text("Network error! ${state.error}"));
          }
          if (state is! WeatherSuccsusssState) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          final weather = state.weatherModel;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    weather.city,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 28),
                  //main weather section
                  MainWeatherSection(weatherModel: weather),
                  const SizedBox(height: 40),
                  WeatherInfoSection(weatherModel: weather),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
