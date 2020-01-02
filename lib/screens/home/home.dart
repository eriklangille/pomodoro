import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/reducer.dart';
import 'package:pomodoro/screens/home/widgets/tasklist/index.dart';
import 'package:pomodoro/widgets/progress_bar/index.dart';
import 'package:pomodoro/data/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/screens/stats/widgets/stats.dart';
import 'package:pomodoro/screens/groups/widgets/groups.dart';
import 'package:pomodoro/screens/profile/widgets/profile.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Pomodoro(),
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
          title: Text("December 28", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
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

  Widget _body() => Container(
    child: Column(
        children: [
          new ProgressBar(progress: 0.3),
          _clock(15, 0),
          Expanded(child: StoreConnector<AppState, _ViewModel>(
            builder: (context, vm) {
              return TaskList(items: vm.items,);
            },
            converter: _ViewModel.fromStore,
          ))
        ]
    ),
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
    children: <Widget>[
      Padding(padding: EdgeInsets.only(bottom:70),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            heroTag: 'add_timer',
            onPressed: () {
              print("Nice");
              vm.addItem(TaskItem("ayy", Colors.red, false, 0, DateTime(0), DateTime(0)));
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.add, color: Colors.black54,),),
        ),),

      Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          heroTag: 'start_timer',
          onPressed: null,
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
  });

  final List<TaskItem> items;
  final Store<AppState> store;
  final Function(TaskItem) addItem;

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      items: store.state.tasks,
      store: store,
      addItem: (item) => store.dispatch(new AddItemAction(item)),
    );
  }

}