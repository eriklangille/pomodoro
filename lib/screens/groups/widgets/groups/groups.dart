import 'package:flutter/material.dart';
import 'package:pomodoro/screens/groups/widgets/grouplist/index.dart';
import 'package:pomodoro/screens/groups/widgets/addGroup/index.dart';
import 'package:pomodoro/screens/groups/widgets/searchGroup/index.dart';


class GroupsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.black54),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new SearchGroupApp())
              );
            }),
          IconButton(icon: Icon(Icons.add, color: Colors.black54),
            onPressed:  () {
              Navigator.push(context, new MaterialPageRoute(
                  builder: (context) =>
                  new AddGroupApp())
              );
            })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GroupList()
    );
  }
}


