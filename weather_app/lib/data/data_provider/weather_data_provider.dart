import 'package:http/http.dart' as http;
import 'package:weather_app/env.dart';

class WeatherDataProvider {
  static const baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  // get weather by current location
  Future<String> getWeatherByCurrentLocation() async {
    try {
      // String cityname = await LocationProvider().getCurrentCity();
      String url = "$baseUrl?q=landon&appid=$API_KEY&units=metric";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("Fail to fetch data");
      }
    } catch (err) {
      throw Exception("something went wrong " + err.toString());
    }
  }
}
