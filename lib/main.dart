import 'package:bloc_learning/cubit/counter_cubit.dart';
import 'package:bloc_learning/pages/cubit_counter_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter BLoC Counter',
        theme: ThemeData(brightness: Brightness.dark),
        home: CubitCounterPage(),
      ),
    );
  }
}
