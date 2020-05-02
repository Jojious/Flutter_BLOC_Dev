import 'package:flutter_bloc/flutter_bloc.dart';

class Delegate extends BlocDelegate{
  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    print(event);
    super.onEvent(bloc, event);
  }
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    print(transition);
    super.onTransition(bloc, transition);
  }
  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}