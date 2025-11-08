part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherinitialState extends WeatherState {}

final class WeatherSuccsusssState extends WeatherState {
  final WeatherModel weatherModel;

  WeatherSuccsusssState({required this.weatherModel});
}

final class WeatherFailedState extends WeatherState {
  final String error;

  WeatherFailedState({required this.error});
}

final class WeatherLoadingState extends WeatherState {}
