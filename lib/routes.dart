import 'package:flutter/material.dart';
import 'screens/home/index.dart';
import 'screens/groups/widgets/groups/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => new Pomodoro()
  };

  Routes () {
    runApp(new MaterialApp(
      title: 'Pomodoro',
      routes: routes,
      home: new Pomodoro(),
    ));
  }
}