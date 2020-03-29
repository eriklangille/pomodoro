import 'package:pomodoro/data/tasks/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:pomodoro/services/database.dart';


ThunkAction addTaskData(TaskItem task) {
  return (Store store) async {
    new Future(() async {
      store.dispatch(new AddItemAction(task));
      final List<TaskItem> _tasks =  store.state.tasksState.tasks;
      DatabaseService _db = new DatabaseService(uid: store.state.userState.currentUser.uid);
      _db.addUserTaskData(task, _tasks.length - 1).then((response) {
        //Nice

      }, onError: (error) {
        print(error);
      });
    });
  };
}

ThunkAction getTasks(String uid) {
  return (Store store) async {
    new Future(() async {
      DatabaseService _db = new DatabaseService(uid: store.state.userState.currentUser.uid);
      _db.getUserTaskData().then((List<TaskItem> tasks) {
        tasks.forEach((f) => store.dispatch(AddItemAction(f)));
      }, onError: (error) {
        print(error);
      });
    });
  };
}

//TODO: Add actions for reordering, modifying, deleting tasks.

class RemoveItemAction {
  final TaskItem item;

  RemoveItemAction(this.item);
}

class AddItemAction {
  final TaskItem item;

  AddItemAction(this.item);
}

class ReorderItemAction {
  final int oldIndex;
  final int newIndex;

  ReorderItemAction(this.oldIndex, this.newIndex);
}

class DisplayPomodoroAction {}
class DisplayNoneAction {}
class DisplayShortBreakAction {}
class DisplayLongBreakAction {}

class SaveListAction {}

class UpdateTimeAction {
  final int newTime;

  UpdateTimeAction(this.newTime);
}

class PlayPauseAction {
}

class StartTimerAction {
  final int startTime;
  final Function() tick;

  StartTimerAction(this.startTime, this.tick);
}

class PomodoroTimerAction{
}

class StopTimerAction {
}

class ShowNewTaskAction {
}
class HideNewTaskAction {
}