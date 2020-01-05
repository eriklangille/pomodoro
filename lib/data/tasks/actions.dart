import 'package:pomodoro/data/tasks/state.dart';

class RemoveItemAction {
  final TaskItem item;

  RemoveItemAction(this.item);
}

class AddItemAction {
  final TaskItem item;

  AddItemAction(this.item);
}

class DisplayPomodoroAction {}
class DisplayNoneAction {}
class DisplayBreakAction {}

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

class StopTimerAction {
}

class ShowNewTaskAction {
}
class HideNewTaskAction {
}