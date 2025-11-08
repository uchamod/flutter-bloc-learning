import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/repos/weather_repostory.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepostory weatherRepostory;
  WeatherBloc(this.weatherRepostory) : super(WeatherinitialState()) {
    on<FetchedWeather>(_fetchedWeather);
  }

  void _fetchedWeather(WeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    try {
      WeatherModel weathermodel =
          await weatherRepostory.getWeatherByCurrentLocation();
      emit(WeatherSuccsusssState(weatherModel: weathermodel));
    } catch (e) {
      emit(WeatherFailedState(error: e.toString()));
    }
  }
}
