part of 'counter_bloc.dart';

//event class
sealed class CounterEvent {}

final class CounterIncremented extends CounterEvent{}

final class CounterDecremented extends CounterEvent{}