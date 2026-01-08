import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather_model.dart';

class MainWeatherSection extends StatelessWidget {
  final WeatherModel weatherModel;
  const MainWeatherSection({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
      String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('h:mm a').format(now);
    return formattedTime;
  }

  
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${weatherModel.temprature}°C",
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              ),
              Text(
                weatherModel.weatherCondition,
                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Text(
                getCurrentTime(),
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
