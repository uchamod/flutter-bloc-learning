import 'package:flutter_bloc/flutter_bloc.dart';

//create a CounterCubit which extends Cubit with an initial state of 0
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  //increment method to increase the counter value by 1
  void increment() => emit(state + 1);

  //decrement method to decrease the counter value by 1
  void decrement() {
    if (state == 0) {
      return;
    }
    emit(state - 1);
  }
}
