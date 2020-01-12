import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/tasks/actions.dart';
import 'package:pomodoro/data/tasks/state.dart';
import 'package:intl/intl.dart';
import 'package:pomodoro/screens/home/widgets/new_task/index.dart';
import 'package:pomodoro/screens/home/widgets/tasklist/index.dart';
import 'package:pomodoro/screens/home/widgets/time_controls/index.dart';
import 'package:pomodoro/widgets/progress_bar/index.dart';
import 'package:pomodoro/data/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/screens/stats/widgets/index.dart';
import 'package:pomodoro/screens/groups/widgets/groups/index.dart';
import 'package:pomodoro/screens/profile/index.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.red,
      ),
      home: Pomodoro()//Pomodoro(),
    );
  }
}

class Pomodoro extends StatefulWidget {
  @override
  PomodoroState createState() => PomodoroState();
}

class PomodoroState extends State<Pomodoro> {
  TextStyle _clockStyle = const TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: 'Roboto',
  );
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          title: Text(DateFormat('MMMM d').format(DateTime.now()), style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
          elevation: 0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.insert_chart, color: Colors.black54),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new StatsApp())
                );
              }),
            IconButton(icon: Icon(Icons.group, color: Colors.black54),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new GroupsApp())
                );
              }),
            IconButton(icon: Icon(Icons.person, color: Colors.black54),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) =>
                    new ProfileApp())
                );
              })
          ]
      ),
      body: _body(),
      floatingActionButton: StoreConnector<AppState, _ViewModel>(
        builder: (context, vm) {
          return _fab(vm);
        },
        converter: _ViewModel.fromStore,
      ),
      backgroundColor: const Color(0xfff2f2f2),
    );
  }

  _addTask(_ViewModel vm, String text, DateTime date) {
    vm.hideNewTask();
    if (text != "") {
      vm.addItem(TaskItem(vm.store.state.tasksState.tasks.length, text, Colors.lightBlue, false, 0, new DateTime.now(), date));
    }
  }
  
  Widget _body() => StoreConnector<AppState, _ViewModel>(
    builder: (context, vm) {
      return Container(
        color: vm.store.state.tasksState.timeState == TimeState.pomodoroTime ? Colors.red : (vm.store.state.tasksState.timeState == TimeState.breakTime ? Colors.blue : Color(0xfff2f2f2)),
        child: Column(
          children: [
            vm.store.state.tasksState.timeState != TimeState.none ? ProgressBar(progress: vm.store.state.tasksState.countdownTime / 10) : Container(),
            vm.store.state.tasksState.timeState != TimeState.none ? _clock(vm.store.state.tasksState.countdownTime ~/ 60, vm.store.state.tasksState.countdownTime % 60) : Container(),
            Expanded(child: new TaskList(items: vm.items, timeState: vm.store.state.tasksState.timeState,)),
            vm.store.state.tasksState.newTask ? NewTask(onSave: (text, chosenDate) => _addTask(vm, text, chosenDate),) : Container(),
            vm.store.state.tasksState.timeState != TimeState.none ? ButtonControls(start: vm.store.state.tasksState.countdown, backgroundColor: vm.store.state.tasksState.timeState == TimeState.pomodoroTime ? Colors.red : Colors.blue, onPlayPause: () => vm.playPause(), onStop: () => vm.noneMode(),) : Container (),
          ]
        ),
      );
    },
    converter: _ViewModel.fromStore,
  );

  Widget _clock(int minute, int second) => Container(
    height: 100,
//    color: Colors.amber,
    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    width: double.infinity,
    alignment: Alignment(0,0),
    child: Text("$minute:${second < 10 ? "0" : ""}$second", style: _clockStyle,),
  );

  Widget _fab(_ViewModel vm) => Stack(
    children: vm.store.state.tasksState.timeState != TimeState.none || vm.store.state.tasksState.newTask ? [] : <Widget>[
      Padding(padding: EdgeInsets.only(bottom:70),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'add_timer',
            onPressed: () {
              vm.showNewTask();
//              vm.addItem(TaskItem("Physics Homework", Colors.lightBlue, false, 69, new DateTime.now(), DateTime(0)));
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black54,),),
        ),),

      Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: () {
            vm.pomodoroMode();
          },
          heroTag: 'start_timer',
          backgroundColor: Colors.red,
          child: Icon(Icons.timer),),
      ),
    ],
  );
}

class _ViewModel {
  _ViewModel({
    this.items,
    this.store,
    this.addItem,
    this.pomodoroMode,
    this.noneMode,
    this.playPause,
    this.showNewTask,
    this.hideNewTask
  });

  final List<TaskItem> items;
  final Store<AppState> store;
  final Function(TaskItem) addItem;
  final Function() pomodoroMode;
  final Function() noneMode;
  final Function() playPause;
  final Function() showNewTask;
  final Function() hideNewTask;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      items: store.state.tasksState.tasks,
      store: store,
      addItem: (item) => store.dispatch(new AddItemAction(item)),
      pomodoroMode: () => store.dispatch(new DisplayPomodoroAction()),
      noneMode: () => store.dispatch(new DisplayNoneAction()),
      playPause: () => store.dispatch(new PlayPauseAction()),
      showNewTask: () => store.dispatch(new ShowNewTaskAction()),
      hideNewTask: () => store.dispatch(new HideNewTaskAction()),
    );
  }

}