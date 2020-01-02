import 'package:flutter/material.dart';
import 'package:pomodoro/screens/groups/widgets/groups/index.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';

class GroupList extends StatefulWidget {
  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {

  List<Group> groups = [
    UBCTryhards, artsStudents
  ];

  Widget groupTemplate(group) {
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
            Image.network(group.picture),
          Text(
            group.name,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TagText(icon: Icons.timer, text: "${group.time}"),
              TagText(icon: Icons.person, text: "${group.people}"),
            ],
          )
        ],
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: groups.map((group) => groupTemplate(group)).toList()
      )
    );
  }
}

class Group {

  String name;
  int time;
  int people;
  String picture;

  Group({this.name, this.time, this.people, this.picture});

}

Group UBCTryhards = Group(
    name: 'UBC Tryhards',
    time: 420,
    people: 69,
    picture: "https://i.kym-cdn.com/photos/images/newsfeed/001/499/826/2f0.png"
);

Group artsStudents = Group(
  name:  "Arts Students",
  time: 0,
  people: 9001,
  picture: "https://media.breitbart.com/media/2018/10/NPC-header-1-640x480.jpg"
);
