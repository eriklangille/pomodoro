import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'screens/home/index.dart';
import 'data/state.dart';
import 'data/reducer.dart';

class PomodoroApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => new MyApp()
  };

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: null,
  );

  @override
  Widget build(BuildContext context) => StoreProvider(
    store: this.store,
    child: new MaterialApp(
      title: 'Pomodoro',
      routes: routes,
      home: new MyApp(),
    ),
  );
}