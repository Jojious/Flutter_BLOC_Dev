import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'counter_event.dart';

part 'counter_state.dart';

const PREF_COUNT = "count";

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  @override
  CounterState get initialState => InitialCounterState();

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    // TODO: Add your event logic
    if (event is IncrementCounter) {
      yield* _mapIncrementCounterToState(event);
    } else if (event is ResetCounter) {
      yield* _mapResetCounterToState();
    } else if (event is SaveCounter) {
      yield* _mapSaveCounterToState(event);
    } else if (event is LoadCounter) {
      yield* _mapLoadCounterToState();
    }
  }

  Stream<CounterState> _mapSaveCounterToState(SaveCounter event) async* {
    try {
      var count = (state as LoadedCounterState).count;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt(PREF_COUNT, count);
      yield SaveCounterState(count);
      event.counterDelegate.onSuccess("successfully");
    } catch (ex) {
      event.counterDelegate.onSuccess(ex.toString());
      yield ErrorCounterState(ex.toString());
    }
  }

  Stream<CounterState> _mapIncrementCounterToState(
      IncrementCounter event) async* {
    try {
      var count = (state as LoadedCounterState).count;
      yield LoadedCounterState(count + event.count);
    } catch (ex) {
      yield ErrorCounterState(ex.toString());
    }
  }

  Stream<CounterState> _mapResetCounterToState() async* {
    try {
      yield LoadedCounterState(0);
    } catch (ex) {
      yield ErrorCounterState(ex.toString());
    }
  }

  Stream<CounterState> _mapLoadCounterToState() async* {
    try {
      yield LoadingCounterState();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final count = preferences.getInt(PREF_COUNT) ?? 0;
      await Future.delayed(Duration(seconds: 2));
      yield LoadedCounterState(count);
    } catch (ex) {
      yield ErrorCounterState(ex.toString());
    }
  }
}
