import 'package:flutter/material.dart';
import 'package:weather_app/presentation/pages/home_screen.dart';
import 'package:weather_app/presentation/pages/search_page.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchPage(),
    const Center(
      child: Text("Profile Page", style: TextStyle(color: Colors.white)),
    ), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1D1B20,
      ), // Dark background matching the "bottom" part
      body: Stack(
        children: [
          // Page Content
          Positioned.fill(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),

          // Custom Floating Bottom Navigation Bar
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E2E), // Darker grey pill
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavIcon(Icons.home_filled, 0),
                    _buildNavIcon(Icons.search, 1),
                    _buildNavIcon(Icons.person_outline, 2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white38,
        size: 30,
      ),
    );
  }
}
