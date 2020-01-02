import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';

AppState appReducer(AppState state, action) => AppState(
    tasksReducer(state.tasks, action),
    timeStateReducer(state.timeState, action),
    countdownTimeReducer(state.countdownTime, action),
    countdownReducer(state.countdown, action),
);

final Reducer<List<TaskItem>> tasksReducer = combineReducers([
  TypedReducer<List<TaskItem>, AddItemAction>(_addItem),
  TypedReducer<List<TaskItem>, RemoveItemAction>(_removeItem),
]);

List<TaskItem> _removeItem(List<TaskItem> tasks, RemoveItemAction action) => List.unmodifiable(List.from(tasks)..remove(action.item));

List<TaskItem> _addItem(List<TaskItem> tasks, AddItemAction action) => List.unmodifiable(List.from(tasks)..add(action.item));

final Reducer<TimeState> timeStateReducer = combineReducers<TimeState>([
  TypedReducer<TimeState, DisplayPomodoroAction>(_displayPomodoro),
  TypedReducer<TimeState, DisplayNoneAction>(_displayNone)
]);

TimeState _displayPomodoro(TimeState timeState, DisplayPomodoroAction action) => timeState == TimeState.pomodoroTime ? TimeState.none : TimeState.pomodoroTime;

TimeState _displayNone(TimeState timeState, DisplayNoneAction action) => TimeState.none;

final Reducer<int> countdownTimeReducer = TypedReducer<int, UpdateTimeAction>(_updateTime);

int _updateTime(int countdownTime, UpdateTimeAction action) => countdownTime = action.newTime;

final Reducer<bool> countdownReducer = TypedReducer<bool, PlayPauseAction>(_playPause);

bool _playPause(bool countdown, PlayPauseAction action) => countdown ? false : true;

// Needs to be moved to actions.dart file eventually but I'm too lazy right now.

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

class SaveListAction {}

class UpdateTimeAction {
  final int newTime;

  UpdateTimeAction(this.newTime);
}

class PlayPauseAction {
}
