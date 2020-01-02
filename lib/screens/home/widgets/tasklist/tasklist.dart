import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/circle_button/index.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';
import 'package:pomodoro/data/state.dart';

class TaskList extends StatefulWidget {
  TaskList({
    this.items,
    this.timeState
  });

  final List<TaskItem> items;
  final TimeState timeState;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontFamily: 'Poppins',
//    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: widget.items.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext ctxt, int index) {
        return _task(widget.items[index], index, widget.timeState);
      }
  );

  Widget _task(TaskItem task, int index, TimeState timeState) =>  Container(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new CircleButton(border: true, color: Color(0xffB1ADAD), onPressed: null),
          Expanded(child:
            Container (
              child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.taskTitle, style: _titleStyle, maxLines: 1, softWrap: false, overflow: TextOverflow.fade, textAlign: TextAlign.left),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new TagText(icon: Icons.timer, text: task.timeFormatted),
                    new TagText(icon: Icons.event, text: "Tomorrow"),
                  ],
                )
              ]
            ),
//            color: Colors.red,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          )
        ),
          new CircleButton(border: false, color: task.taskColor, onPressed: null),
        ]
    ),
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(12),
    ),
    foregroundDecoration: BoxDecoration(
      color: (index == 0 || timeState == TimeState.none) ? Color(0x00ffffff) : Colors.red.withOpacity(0.2 + (0.1 * (index < 8 ? index: 7))),
    ),
  );

}