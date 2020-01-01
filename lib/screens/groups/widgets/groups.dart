import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/groups/actions.dart';
import 'package:pomodoro/data/groups/reducer.dart';
import 'package:pomodoro/data/groups/state.dart';

class GroupsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        elevation: 0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_back, color: Colors.black54), onPressed: null),
          IconButton(icon: Icon(Icons.search, color: Colors.black54), onPressed: null),
          IconButton(icon: Icon(Icons.add, color: Colors.black54), onPressed: null)
        ],
        backgroundColor: Colors.white,
      ),
    );
  }
}


