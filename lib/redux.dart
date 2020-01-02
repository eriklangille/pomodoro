import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/screens/home/index.dart';
import 'package:pomodoro/screens/stats/widgets/index.dart';
import 'package:pomodoro/screens/groups/widgets/groups/index.dart';
import 'package:pomodoro/screens/profile/widgets/index.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/data/reducer.dart';


class PomodoroApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => new MyApp(),
    '/stats': (BuildContext context) => new StatsApp(),
    '/groups': (BuildContext context) => new GroupsApp(),
    '/profile': (BuildContext context) => new ProfileApp()
  };

  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
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