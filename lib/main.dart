import 'package:bloc_learning/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC',
      theme: ThemeData(
       brightness: Brightness.dark
      ),
      home: MainPage(),
    );
  }
}