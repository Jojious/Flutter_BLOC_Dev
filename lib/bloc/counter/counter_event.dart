part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

abstract class CounterDelegate{
  void onSuccess(String message);
  void onError(String message);
}

class IncrementCounter extends CounterEvent {
  final int count;

  IncrementCounter(this.count);

  @override
  String toString() => "IncrementCounter{count: $count}";
}

class ResetCounter extends CounterEvent {
  @override
  String toString() => "ResetCounter{}";
}

class LoadCounter extends CounterEvent {
  @override
  String toString() => "LoadCounter{}";
}

class SaveCounter extends CounterEvent {
  final CounterDelegate counterDelegate;

  SaveCounter(this.counterDelegate);
  @override
  String toString() => "SaveCounter{$counterDelegate}";
}
