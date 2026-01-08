import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather_model.dart';

class WeatherInfoSection extends StatelessWidget {
  final WeatherModel weatherModel;
  const WeatherInfoSection({super.key, required this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.lightBlue, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //discription
          Text(
            weatherModel.weatherDiscription,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ).copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          //feels_like
          weatherProperty(
            "feels_Like",
            Icons.hotel_class,
            weatherModel.feelsLike,
            "°C",
          ),
          const Divider(color: Colors.white),
          //min temp
          weatherProperty(
            "min_temp",
            Icons.arrow_downward_outlined,
            weatherModel.minTemp,
            "°C",
          ),
          const Divider(color: Colors.white54),
          //max temp
          weatherProperty(
            "max_temp",
            Icons.arrow_upward,
            weatherModel.maxTemp,
            "°C",
          ),
          const Divider(color: Colors.white54),
          //preasure
          weatherProperty(
            "wind_speed",
            Icons.wind_power,
            weatherModel.windSpeed,
            "m/s",
          ),
          const Divider(color: Colors.white54),
          //wind spped
          weatherProperty(
            "pressuer",
            Icons.pool_rounded,
            weatherModel.preasure,
            "hpa",
          ),
          const Divider(color: Colors.white54),
          //humadity
          weatherProperty(
            "humidity",
            Icons.water_drop,
            weatherModel.humadity,
            "%",
          ),
          const Divider(color: Colors.white54),
          //vissibility
          weatherProperty(
            "visibility",
            Icons.visibility,
            weatherModel.visibility,
            "",
          ),
        ],
      ),
    );
  }

  Widget weatherProperty(
    String name,
    IconData icon,
    dynamic value,
    String prefix,
  ) {
    return Row(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ).copyWith(color: Colors.white),
        ),
        const SizedBox(width: 10),
        Icon(icon, size: 20, color: Colors.white),
        const Spacer(),
        Text(
          value.toString() + prefix,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ).copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
