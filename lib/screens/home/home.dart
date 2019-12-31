import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home/widgets/tasklist/index.dart';
import 'package:pomodoro/widgets/progress_bar/index.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  @override
  PomodoroState createState() => PomodoroState();
}

class PomodoroState extends State<Pomodoro> {
  TextStyle _clockStyle = const TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Roboto',
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar (
          title: Text("December 28", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.insert_chart, color: Colors.black54), onPressed: null,),
            IconButton(icon: Icon(Icons.group, color: Colors.black54), onPressed: null,),
            IconButton(icon: Icon(Icons.person, color: Colors.black54), onPressed: null,)
          ]
      ),
      body: _body(),
      floatingActionButton: _fab(),
      backgroundColor: const Color(0xfff2f2f2),
    );
  }

  Widget _body() => Container(
    child: Column(
        children: [
          new ProgressBar(progress: 0.3),
          _clock(15, 0),
          Expanded(child: new TaskList())
        ]
    ),
  );

  Widget _clock(int minute, int second) => Container(
    height: 100,
//    color: Colors.amber,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    width: double.infinity,
    alignment: Alignment(0,0),
    child: Text("$minute:${second < 10 ? "0" : ""}$second", style: _clockStyle,),
  );

  Widget _fab() => Stack(
    children: <Widget>[
      Padding(padding: EdgeInsets.only(bottom:70),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black54,),),
        ),),

      Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: null,
          backgroundColor: Colors.red,
          child: Icon(Icons.timer),),
      ),
    ],
  );
}