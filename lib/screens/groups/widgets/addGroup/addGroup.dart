import 'package:flutter/material.dart';
import 'package:pomodoro/screens/groups/widgets/grouplist/index.dart';

class AddGroupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.done, color: Colors.black87),
            onPressed: () {
              Navigator.pop(context);
            })
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      body: NewGroup()
    );
  }
}

class NewGroup extends StatefulWidget {
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {

  Widget newGroupFormField () {
    return Column(
      children: <Widget>[
        TextFormField(
            decoration: InputDecoration(
                labelText: "Group Name"
            ),
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Group Description"
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: newGroupFormField()
    );
  }
}
