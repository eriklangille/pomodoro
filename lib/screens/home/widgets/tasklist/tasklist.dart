import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/circle_button/index.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';

class TaskList extends StatelessWidget {
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontFamily: 'Poppins',
  );

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: 20,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext ctxt, int index) {
        return _task("Physics Homework", Colors.blue);
      }
  );

  Widget _task(String title, Color color) =>  Container(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new CircleButton(border: true, color: Color(0xffB1ADAD), onPressed: null),
          Column(
              children: [
                Text(title, style: _titleStyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    new TagText(icon: Icons.timer, text: "1h 11m"),
                    new TagText(icon: Icons.event, text: "Tomorrow"),
                  ],
                )
              ]
          ),
          new CircleButton(border: false, color: Colors.lightBlue, onPressed: null),
        ]
    ),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xffffffff),
      borderRadius: BorderRadius.circular(12),
    ),
  );

}