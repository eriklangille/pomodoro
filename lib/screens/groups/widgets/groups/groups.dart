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
      body: GroupList(),
    );
  }
}


class AddGroupButton extends StatelessWidget {

  _onSaveGroup(String name, String description) {
    groups.add(
      Group(
        name: name,
        description: description,
        time: 0,
        members: [
          Member(name: "Joe Average") // Add the name of the name of the user who made the group to the members list
        ],
        picture: "https://s16-us2.startpage.com/cgi-bin/serveimage?url=https%3A%2F%2Fichef.bbci.co.uk%2Fnews%2F976%2Fcpsprodpb%2F16620%2Fproduction%2F_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg&sp=f4629ef85acb1bdc8a475266618e31c8&anticache=596401"
      )
    );
  } // add the new saved group to groups


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
      MaterialPageRoute(builder: (context) => AddGroupAppCaller(onSaveGroup: (name, description) => _onSaveGroup(name, description),)),
    );
  }
}
