import 'dart:convert';

import 'package:weather_app/data/data_provider/weather_data_provider.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherRepostory {
  final WeatherDataProvider weatherDataProvider;

  WeatherRepostory({required this.weatherDataProvider});
  Future<WeatherModel> getWeatherByCurrentLocation() async {
    try {
      final response = await weatherDataProvider.getWeatherByCurrentLocation();

      final weatherData = jsonDecode(response);
      if (weatherData["cod"] == 200) {
        return WeatherModel.fromJson(weatherData);
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (err) {
      throw Exception("something went wrong " + err.toString());
    }
  }
}
