import 'package:flutter/material.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleImage(link: group.picture, radius: 100,),
          Expanded(child:
          Container(
            child:
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(group.name,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black87
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.left),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new TagText(icon: Icons.timer, text: "${group.time ~/ 60}h ${group.time % 60}m"),
                      new TagText(icon: Icons.person, text: "0"), // fix this code
                    ],
                  )
                ]
            ),
//            color: Colors.red,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          )
          ),
        ],
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
  String description;
  int time;
  List<Member> members;
  String picture;

  Group({this.name, this.description, this.time, this.members, this.picture,});

}

class Member {

  String name;

  Member({this.name,});

}

class MembersLength extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class CircleImage extends StatelessWidget {

  final String link;
  final double radius;

  CircleImage({this.link, this.radius});

  @override
  Widget build(BuildContext context) {
    double _radius = 100;

    return Container(
      child: new Container(
        width: _radius,
        height: _radius,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new NetworkImage(link)
          )
        )
      )
    );
  }
}


Group UBCTryhards = Group(
    name: 'UBC Tryhards',
    description: "Pain is temporary GPA is forever",
    time: 420,
    members: [
      Member(name: "James Ryeburn",),
      Member(name: "Erik Langille",),
    ],
    picture: "https://i.kym-cdn.com/photos/images/newsfeed/001/499/826/2f0.png"
);

Group artsStudents = Group(
  name:  "Arts Students",
  description: "We have a lot of term papers",
  time: 0,
  members: [
    Member(name: "John Doe",),
    Member(name: "Mary Sue",),
    Member(name: "Billy Bob",),
  ],
  picture: "https://media.breitbart.com/media/2018/10/NPC-header-1-640x480.jpg"
);