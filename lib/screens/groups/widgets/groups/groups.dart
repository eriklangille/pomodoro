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
          AddGroupButton(),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GroupList()
    );
  }
}


class AddGroupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add, color: Colors.black54),
      onPressed: () {
        _navigateAndDisplayAddGroup(context);
      },
    );
  }

  // A method that launches the addGroup screen and awaits the
  // result from the Navigator.pop
  _navigateAndDisplayAddGroup(BuildContext context) async {
    //Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => AddGroupAppCaller()),
    );
  }
}
