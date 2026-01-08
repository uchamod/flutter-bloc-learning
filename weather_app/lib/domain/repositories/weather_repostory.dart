import 'dart:convert';

import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repositories/location_provider.dart';
import 'package:weather_app/data/repositories/weather_repositort_impl.dart';

class WeatherRepostory {
  final WeatherDataProvider weatherDataProvider;
  final LocationProvider locationProvider;

  WeatherRepostory({
    required this.weatherDataProvider,
    required this.locationProvider,
  });
  //get current location
  Future<WeatherModel> getWeatherByCurrentLocation() async {
    try {
      final String cityName = await locationProvider.getCurrentCity();
      final response = await weatherDataProvider.getWeather(cityName);

      final weatherData = jsonDecode(response);
      if (weatherData["cod"] == 200) {
        return WeatherModel.fromJson(weatherData);
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (err) {
      throw Exception("something went wrong $err");
    }
  }

  //search location
  Future<WeatherModel> searchWeatherByLocation({required String city}) async {
    try {
      final response = await weatherDataProvider.getWeather(city);

      final weatherData = jsonDecode(response);
      if (weatherData["cod"] == 200) {
        return WeatherModel.fromJson(weatherData);
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (err) {
      throw Exception("something went wrong $err");
    }
  }
}
