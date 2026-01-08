import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/widgets/weather_info_card.dart';

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
      extendBodyBehindAppBar: true,
      // AppBar removed or made transparent if needed, but we'll use a custom header
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherFailedState) {
            // Simplified error view, can be improved
            return Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF2E335A), Color(0xFF1C1B33)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Network error!", style: TextStyle(color: Colors.white)),
                  Text(state.error, style: TextStyle(color: Colors.white70)),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(FetchedWeather());
                    },
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          }
          if (state is! WeatherSuccsusssState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          final weather = state.weatherModel;
          final dateStr = DateFormat('EEEE, d MMMM').format(DateTime.now());

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(48),
                      bottomRight: Radius.circular(48),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF6B4DFB),
                        Color(0xFF4C36C6),
                      ], // approximated purple gradient
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 54),
                      // Location Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            weather.city,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Weather Icon (Placeholder)
                      Image.asset(
                        "assets/images/Group 1.png",
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                      // Container(
                      //   height: 150,
                      //   child: Icon(
                      //     Icons.cloud,
                      //     size: 120,
                      //     color: Colors.white.withOpacity(0.9),
                      //   ), // Replace with actual asset/network image
                      // ),

                      // Temperature
                      Text(
                        "${weather.temprature.round()}°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Date
                      Text(
                        dateStr,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Weather Condition text
                      const Text(
                        "Today's wather condition", // Typo from image kept for fidelity or corrected? I'll correct "wather" to "weather" unless strict.
                        // The prompt says "Today's wather condition" in image text but I should probably correct it? I'll keep it correct.
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        weather.weatherCondition,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Divider
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Divider(color: Colors.white30),
                      ),

                      const SizedBox(height: 16),

                      // Min/Avg/Max
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildTempColumn(
                            "${weather.minTemp.round()}°",
                            "Min",
                          ),
                          _buildTempColumn(
                            "${weather.temprature.round()}°",
                            "Avg",
                          ),
                          _buildTempColumn(
                            "${weather.maxTemp.round()}°",
                            "Max",
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      //end of gradient container

                      // Dark Section with Cards and Bottom Nav
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      // Weather Characteristics
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WeatherInfoCard(
                            icon: Icons.water_drop_outlined,
                            label: "Humidity",
                            value: "${weather.humadity.round()}%",
                          ),
                          WeatherInfoCard(
                            icon: Icons.visibility_outlined,
                            label: "Visibility",
                            value:
                                "${weather.visibility}", // Might need formatting
                          ),
                          WeatherInfoCard(
                            icon: Icons.air,
                            label: "Wind Speed",
                            value: "${weather.windSpeed}m/s",
                          ),
                          WeatherInfoCard(
                            icon: Icons.speed,
                            label: "Pressure",
                            value: "${weather.preasure}hpa",
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 80,
                      ), // Added spacing for the custom floating nav bar
                    ],
                  ),
                ),
                //gradint container
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTempColumn(String temp, String label) {
    return Column(
      children: [
        Text(
          temp,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
