import 'package:redux/redux.dart';
import 'package:pomodoro/data/tasks/state.dart';
import 'package:pomodoro/data/tasks/actions.dart';
import 'dart:async';

TasksState tasksReducer(TasksState state, action) => TasksState(
  tasksItemReducer(state.tasks, action),
  timeStateReducer(state.timeState, action),
  countdownTimeReducer(state.countdownTime, action),
  countdownReducer(state.countdown, action),
  countdownTimerReducer(state.countdownTimer, action),
  newTaskReducer(state.newTask, action),
);

final Reducer<List<TaskItem>> tasksItemReducer = combineReducers([
  TypedReducer<List<TaskItem>, AddItemAction>(_addItem),
  TypedReducer<List<TaskItem>, RemoveItemAction>(_removeItem),
]);

List<TaskItem> _removeItem(List<TaskItem> tasks, RemoveItemAction action) => List.unmodifiable(List.from(tasks)..remove(action.item));

List<TaskItem> _addItem(List<TaskItem> tasks, AddItemAction action) => List.unmodifiable(List.from(tasks)..add(action.item));

final Reducer<TimeState> timeStateReducer = combineReducers<TimeState>([
  TypedReducer<TimeState, DisplayPomodoroAction>(_displayPomodoro),
  TypedReducer<TimeState, DisplayShortBreakAction>(_displayShortBreak),
  TypedReducer<TimeState, DisplayLongBreakAction>(_displayLongBreak),
  TypedReducer<TimeState, DisplayNoneAction>(_displayNone)
]);

TimeState _displayPomodoro(TimeState timeState, DisplayPomodoroAction action) => TimeState.pomodoroTime;

TimeState _displayShortBreak(TimeState timeState, DisplayShortBreakAction action) => TimeState.shortBreakTime;

TimeState _displayLongBreak(TimeState timeState, DisplayLongBreakAction action) => TimeState.longBreakTime;

TimeState _displayNone(TimeState timeState, DisplayNoneAction action) => TimeState.none;

final Reducer<int> countdownTimeReducer = TypedReducer<int, UpdateTimeAction>(_updateTime);

int _updateTime(int countdownTime, UpdateTimeAction action) => countdownTime = action.newTime;

final Reducer<bool> countdownReducer = TypedReducer<bool, PlayPauseAction>(_playPause);

bool _playPause(bool countdown, PlayPauseAction action) => countdown ? false : true;

final Reducer<Timer> countdownTimerReducer = combineReducers<Timer>([
  TypedReducer<Timer, StartTimerAction>(_startTimer),
  TypedReducer<Timer, StopTimerAction>(_stopTimer),
]);

Timer _startTimer(Timer timer, StartTimerAction action) {
  if(timer == null) {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
        oneSec,
            (Timer timer) => action.tick()
    );
  }
  return timer;
}

Timer _stopTimer(Timer timer, StopTimerAction action) {
  if(timer != null) {
    timer.cancel();
  }
  return null;
}

final Reducer<bool> newTaskReducer = combineReducers<bool>([
  TypedReducer<bool, ShowNewTaskAction>(_newTask),
  TypedReducer<bool, HideNewTaskAction>(_hideNewTask),
]);

bool _newTask(bool newTask, ShowNewTaskAction action) => true;
bool _hideNewTask(bool newTask, HideNewTaskAction action) => false;
// Needs to be moved to actions.dart file eventually but I'm too lazy right now.
