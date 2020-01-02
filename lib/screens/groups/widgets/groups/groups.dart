import 'package:flutter/material.dart';
import 'package:pomodoro/screens/groups/widgets/grouplist/index.dart';

class GroupsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.black54),
            onPressed: null,),
          IconButton(icon: Icon(Icons.add, color: Colors.black54),
            onPressed: null,)
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GroupList()
    );
  }
}


