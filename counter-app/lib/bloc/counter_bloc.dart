import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_event.dart';

//bloc needs to provide event rather than state
//event basically a function/class or any action that update the state
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncremented>((event, emit) {
      emit(state + 1);
    });

    on<CounterDecremented>((event, emit) {
      if (state == 0) {
        return;
      }
      emit(state - 1);
    });
  }
}
