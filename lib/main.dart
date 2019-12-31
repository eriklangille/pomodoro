// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

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
   TextStyle _titleStyle = const TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontFamily: 'Poppins',
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
        _progressBar(),
        Expanded(child: _taskList())
      ]
    ),
  );

  Widget _progressBar() => Container(
    height: 5,
    width: 100,
    decoration: BoxDecoration(
      color: Colors.black12
    ),
    child: FractionallySizedBox(
      widthFactor: 0.8,
      alignment: AlignmentDirectional.topStart,
        child: Container(
        color: Colors.red,
      )
    ),
  );

  Widget _taskList() {
    return ListView.builder(
        itemCount: 20,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext ctxt, int index) {
          return _task("Physics Homework", Colors.blue);
        }
    );
  }

  Widget _task(String title, Color color) =>  Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _circle(true, Color(0xffB1ADAD)),
        Column(
            children: [
              Text(title, style: _titleStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _tag(Icons.timer, "1h 11m"),
                  _tag(Icons.event, "Tomorrow")
                ],
              )
            ]
        ),
        _circle(false, Colors.lightBlue)
      ]
    ),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xffffffff),
      borderRadius: BorderRadius.circular(12),
    ),
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

  Widget _circle(bool border, Color color) => Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: border ? Color(0) : color,
        border: border ? Border.all(
          color: color,
          width: 1,
        ) : null,
    ),
  );

  Widget _tag(IconData icon, String text) => Container(
    child: Row(
      children: [
        Icon(icon, color: Colors.black54, size: 11,),
        Text(text)
      ],
    ),
  );


}