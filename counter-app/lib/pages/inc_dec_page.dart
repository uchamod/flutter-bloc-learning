import 'package:bloc_learning/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncrementDecrementPage extends StatelessWidget {
  const IncrementDecrementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Increament or decrement the count")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  shape: CircleBorder(
                    eccentricity: 0.0,
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.add),
                  onPressed: () {
                    counterBloc.add(CounterIncremented());
                    //for cubit
                    // counterCubit.increment();
                  },
                ),
                //decrement button
                FloatingActionButton(
                  shape: CircleBorder(
                    eccentricity: 0.0,
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.remove),
                  onPressed: () {
                    counterBloc.add(CounterDecremented());
                    //counterCubit.decrement();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
