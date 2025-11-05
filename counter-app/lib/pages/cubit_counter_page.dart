import 'package:bloc_learning/bloc/counter_bloc.dart';
import 'package:bloc_learning/pages/inc_dec_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitCounterPage extends StatelessWidget {
  CubitCounterPage({super.key});
  //create an instance of CounterCubit
  // CounterCubit counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    //optional
    //  final counterCubit = BlocProvider.of<CounterCubit>(context);
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("BLoC Example")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text("This is Cubit Counter Page"),
            SizedBox(height: 8),
            BlocBuilder<CounterBloc, int>(
              bloc: counterBloc, //optional
              builder: (context, count) {
                return Text("Counter Value: $count");
              },
            ),
            SizedBox(height: 8),
            Row(
              children: [
                //increment button
                FloatingActionButton(
                  shape: CircleBorder(
                    eccentricity: 0.0,
                    side: BorderSide(width: 1, color: Colors.black),
                  ),
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.add),
                  onPressed: () {
                    counterBloc.add(CounterIncremented());
                    //counterCubit.increment();
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
                    // counterCubit.decrement();
                  },
                ),
              ],
            ),
            SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => IncrementDecrementPage()),
                );
              },
              child: Text("Go to increment decrement page"),
            ),
          ],
        ),
      ),
    );
  }
}
