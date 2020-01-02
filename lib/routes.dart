import 'package:flutter/material.dart';
import 'screens/home/index.dart';
import 'screens/groups/widgets/index.dart';

class Routes {
  final routes = <String, WidgetBuilder>{
    '/home': (BuildContext context) => new MyApp()
  };

  Routes () {
    runApp(new MaterialApp(
      title: 'Pomodoro',
      routes: routes,
      home: new MyApp(),
    ));
  }
}