class WeatherModel {
  final String city;
  final double temprature;
  final String weatherCondition;
  final String weatherDiscription;
  final double windSpeed;
  final double humadity;
  final double preasure;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final double visibility;

  WeatherModel({
    required this.city,
    required this.temprature,
    required this.weatherCondition,
    required this.weatherDiscription,
    required this.windSpeed,
    required this.humadity,
    required this.preasure,
    required this.feelsLike,
    required this.minTemp,
    required this.maxTemp,
    required this.visibility,
  });

  //convert specific json data to dart model
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json["name"],
      temprature: json["main"]["temp"].toDouble(),
      weatherCondition: json["weather"][0]["main"],
      weatherDiscription: json["weather"][0]["description"],
      windSpeed: json["wind"]["speed"].toDouble(),
      humadity: json["main"]["humidity"].toDouble(),
      preasure: json["main"]["pressure"].toDouble(),
      feelsLike: json["main"]["feels_like"].toDouble(),
      minTemp: json["main"]["temp_min"].toDouble(),
      maxTemp: json["main"]["temp_max"].toDouble(),
      visibility: json["visibility"].toDouble(),
    );
  }
}
