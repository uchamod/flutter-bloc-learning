import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/bloc/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchSubmitted(String value) {
    if (value.isNotEmpty) {
      context.read<SearchBloc>().add(SearchWeather(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1B20),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          // If in SearchInitial state, show the large title UI.
          if (state is SearchInitial) {
            return _buildInitialUI();
          }
          // If in Loading, Success or Failure, show the Result UI structure covering the same area
          return _buildResultUI(state);
        },
      ),
    );
  }

  Widget _buildInitialUI() {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6B4DFB), Color(0xFF7F52FF)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildSearchBar(isInitial: true),
                const Spacer(),
                const Text(
                  "Find Weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const Text(
                  "Any Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }

  Widget _buildResultUI(SearchState state) {
    return Column(
      children: [
        // Make the purple container take up more space to fit the content
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6B4DFB), Color(0xFF7F52FF)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                _buildSearchBar(isInitial: false),

                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (state is SearchFailure) {
                        return Center(
                          child: Text(
                            "Error: ${state.error}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      if (state is SearchSuccess) {
                        final weather = state.weatherModel;
                        final dateStr = DateFormat(
                          'EEEE,d MMMM',
                        ).format(DateTime.now());

                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              // Location with Icon
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${weather.city},${_getCountryCode(weather)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Temp
                              Text(
                                "${weather.temprature.round()}°",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 100,
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

                              const SizedBox(height: 20),

                              // Condition
                              Text(
                                weather.weatherCondition,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 40),

                              // 4 Cards Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildSearchStatCard(
                                    Icons.water_drop,
                                    "Humidity",
                                    "${weather.humadity.round()}%",
                                  ),
                                  _buildSearchStatCard(
                                    Icons.visibility,
                                    "Visibility",
                                    "${weather.visibility}",
                                  ),
                                  _buildSearchStatCard(
                                    Icons.air,
                                    "Wind\nSpeed",
                                    "${weather.windSpeed}m/s",
                                  ),
                                  _buildSearchStatCard(
                                    Icons.speed,
                                    "Pressuer",
                                    "${weather.preasure}hpa",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Spacer for Bottom Nav
        const SizedBox(height: 80),
      ],
    );
  }

  String _getCountryCode(dynamic weather) {
    return "";
  }

  Widget _buildSearchBar({required bool isInitial}) {
    // Initial style is White, Result style is lighter purple.
    final bgColor = isInitial ? Colors.white : const Color(0xFF8F76FF);
    final iconColor = isInitial ? Colors.grey : Colors.white;
    final hintColor = isInitial ? Colors.grey : Colors.white70;
    final inputColor = isInitial ? Colors.black : Colors.white;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        style: TextStyle(color: inputColor),
        onSubmitted: _onSearchSubmitted,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: hintColor),
          prefixIcon: Icon(Icons.search, color: iconColor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 11,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchStatCard(IconData icon, String label, String value) {
    return Container(
      width: 75,
      height: 110,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF5E4FC1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          const Spacer(),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
