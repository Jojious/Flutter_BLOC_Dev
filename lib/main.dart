import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop01bloc/bloc/counter/counter_bloc.dart';
import 'package:workshop01bloc/bloc/delegate.dart';

void main() {
  BlocSupervisor.delegate = Delegate();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: BlocProvider(
        create: (BuildContext context) => CounterBloc(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget implements CounterDelegate {
  CounterBloc _counterBloc;

  var _context;

  @override
  void onError(String message) {
    // TODO: implement onError
    _showAlertDialog(message);
  }

  @override
  void onSuccess(String message) {
    // TODO: implement onSuccess
    _showAlertDialog(message);
  }

  @override
  Widget build(BuildContext context) {
    _counterBloc = BlocProvider.of<CounterBloc>(context);
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc Demo"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _counterBloc.add(LoadCounter());
              }),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _counterBloc.add(SaveCounter(this));
              })
        ],
      ),
      body: BlocBuilder(
          bloc: _counterBloc,
          builder: (BuildContext context, CounterState state) {
            if (state is LoadedCounterState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state.count.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            }
            if (state is ErrorCounterState) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is InitialCounterState || state is SaveCounterState) {
              _counterBloc.add(LoadCounter());
              return SizedBox();
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _counterBloc.add(IncrementCounter(500));
            },
            child: Icon(Icons.add),
          ),
          SizedBox(
            height: 12,
          ),
          FloatingActionButton(
            onPressed: () {
              _counterBloc.add(ResetCounter());
            },
            child: Icon(Icons.restore),
          ),
        ],
      ),
    );
  }

  void _showAlertDialog(String message) {
    showDialog<void>(
      context: _context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('close'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
