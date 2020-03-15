import 'package:flutter/material.dart';
import 'package:pomodoro/util/parsedate.dart';
import 'package:pomodoro/widgets/circle_button/index.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';
import 'package:pomodoro/data/tasks/state.dart';
import 'package:pomodoro/util/reorderable_list.dart';

class TaskList extends StatefulWidget {
  TaskList({
    this.items,
    this.timeState,
    this.reorderItem,
  });

  final List<TaskItem> items;
  final TimeState timeState;
  final Function(int oldIndex, int newIndex) reorderItem;

  @override
  _TaskListState createState() => _TaskListState();
}

enum DraggingMode {
  iOS,
  Android,
}

class _TaskListState extends State<TaskList> {
  final TextStyle _titleStyle = const TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontFamily: 'Poppins',
//    backgroundColor: Colors.green,
  );

//  @override
//  Widget build(BuildContext context) => ReorderableListView(
//    onReorder: (int oldIndex, int newIndex) {widget.reorderItem(oldIndex, newIndex);},
//    scrollDirection: Axis.vertical,
////    padding: const EdgeInsets.all(8),
//    children: List.generate(widget.items.length,
//    (index) {
//      return _task(widget.items[index], index, widget.timeState);
//    }),
//  );
//  @override
//  Widget build(BuildContext context) => ListView.builder(
//      itemCount: widget.items.length,
//      scrollDirection: Axis.vertical,
//      shrinkWrap: true,
//      padding: const EdgeInsets.all(8),
//      itemBuilder: (BuildContext ctxt, int index) {
//        return _task(widget.items[index], index, widget.timeState);
//      }
//  );

  @override
  Widget build(BuildContext context) => ReorderableList(
    onReorder: this._onReorder,
    onReorderDone: null,
    enableDragDecoration: false,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Task(
                      task: widget.items[index],
                      index: index,
                      timeState: widget.timeState
                  );
                },
                childCount: widget.items.length,
              ),
            )),
      ],
    ),
  );

  int _indexOfKey(Key key) {
    return widget.items.indexWhere((TaskItem d) => d.key == key);
  }

  bool _onReorder(Key item, Key newPosition) {
    int oldIndex = _indexOfKey(item);
    int newIndex = _indexOfKey(newPosition);
//    print("old: $oldIndex new: $newIndex");
    widget.reorderItem(oldIndex,newIndex);
    return true;
  }

  Widget _task(TaskItem task, int index, TimeState timeState) =>  Container(
    key: Key('$index'),
    height: 70,
    child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    new TagText(icon: Icons.event, text: ParseDate.showDay(task.dueAt)),
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
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
    decoration: BoxDecoration(
      color: Color(0xffffffff),
      borderRadius: BorderRadius.circular(12),
    ),
    foregroundDecoration: BoxDecoration(
      color: (index == 0 || timeState != TimeState.pomodoroTime) ? Color(0x00ffffff) : Colors.red.withOpacity(0.2 + (0.1 * (index < 8 ? index: 7))),
    ),
  );

}

class Task extends StatelessWidget {
  Task({
    this.task,
    this.index,
    this.timeState,
  });

  final TaskItem task;
  final int index;
  final TimeState timeState;

  final TextStyle _titleStyle = const TextStyle(
    fontSize: 20.0,
    color: Colors.black87,
    fontFamily: 'Poppins',
//    backgroundColor: Colors.green,
  );

  Widget _buildChild(BuildContext context, ReorderableItemState state) {
    BoxDecoration decoration;

    if (state == ReorderableItemState.dragProxy ||
        state == ReorderableItemState.dragProxyFinished) {
      // slightly transparent background white dragging (just like on iOS)
      decoration = BoxDecoration(
//        color: Color(0xD0FFFFFF),
        borderRadius: BorderRadius.circular(12),
      );
    } else {
      bool placeholder = state == ReorderableItemState.placeholder;
      decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border(
            top: !placeholder
                ? Divider.createBorderSide(context) //
                : BorderSide.none,
            bottom: placeholder
                ? BorderSide.none //
                : Divider.createBorderSide(context)),
//          color: placeholder ? Colors.white : Colors.white
      );
    }

    bool placeholder = state == ReorderableItemState.placeholder;

    return DelayedReorderableListener(child: Container(
//        height: 70,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        foregroundDecoration: BoxDecoration(
          color: (index == 0 || timeState != TimeState.pomodoroTime) ? Color(
              0x00ffffff) : Colors.red.withOpacity(
              0.2 + (0.1 * (index < 8 ? index : 7))),
        ),
//        decoration: decoration,
        decoration: BoxDecoration(
          color: placeholder ? null : Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: SafeArea(
            top: false,
            bottom: false,
            child: Opacity(
                opacity: state == ReorderableItemState.placeholder ? 0 : 1.0,
                child: IntrinsicHeight(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          new CircleButton(border: true,
                              color: Color(0xffB1ADAD),
                              onPressed: null),
                          Expanded(child:
                          Container(
                            child:
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(task.taskTitle, style: _titleStyle,
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      textAlign: TextAlign.left),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      new TagText(icon: Icons.timer,
                                          text: task.timeFormatted),
                                      new TagText(icon: Icons.event,
                                          text: ParseDate.showDay(task.dueAt)),
                                    ],
                                  )
                                ]
                            ),
//            color: Colors.red,
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          )
                          ),
                          new CircleButton(border: false,
                              color: task.taskColor,
                              onPressed: () => print("category")),
                        ]
                    )
                )
            )
        )
    )
    );
  }
    @override
    Widget build(BuildContext context) {
      return ReorderableItem(
          key: task.key, //
          childBuilder: _buildChild);
    }
  }


