part of 'counter_bloc.dart';

@immutable
abstract class CounterState {}

class InitialCounterState extends CounterState {
  @override
  String toString() => "InitialCounterState{}";
}

class LoadingCounterState extends CounterState {
  @override
  String toString() => "LoadingCounterState{}";
}

class LoadedCounterState extends CounterState {
  final int count;
  LoadedCounterState(this.count);
  @override
  String toString() => "LoadedCounterState{count: $count}";
}

class SaveCounterState extends CounterState {
  final int count;
  SaveCounterState(this.count);
  @override
  String toString() => "SaveCounterState{count: $count}";
}

class ErrorCounterState extends CounterState {
  final String error;

  ErrorCounterState(this.error);
  @override
  String toString() => "ErrorCounterState{count: $error}";
}