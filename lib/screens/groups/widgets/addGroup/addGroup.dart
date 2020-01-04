import 'package:flutter/material.dart';
import 'package:pomodoro/screens/groups/widgets/grouplist/index.dart';

class AddGroupAppCaller extends StatelessWidget {
  final Function(String name, String description) onSaveGroup;

  AddGroupAppCaller({this.onSaveGroup});

  @override
  Widget build(BuildContext context) {
    return AddGroupApp(onSaveGroup: (name, description) => onSaveGroup(name, description));
  }
}


class AddGroupApp extends StatefulWidget {
  final Function(String name, String description) onSaveGroup;

  AddGroupApp({this.onSaveGroup});

  @override
  _AddGroupAppState createState() => _AddGroupAppState(onSaveGroup: (name, description) => onSaveGroup(name, description));
}

class _AddGroupAppState extends State<AddGroupApp> {
  Function(String name, String description) onSaveGroup;

  _AddGroupAppState({this.onSaveGroup});

  String _name = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done, color: Colors.black87),
              onPressed: () {
                Navigator.pop(context);
                onSaveGroup(_name, _description);
              })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
              decoration: InputDecoration(
                  labelText: "Group Name"
              ),
              onChanged: (String value) async {
                _name = value;
              }
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Group Description"
            ),
            onChanged: (String value) async {
              _description = value;
            },
          ),
        ],
      ),
    );
  }
}
