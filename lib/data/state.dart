import 'package:pomodoro/data/tasks/state.dart';

class AppState {
  final TasksState tasksState;

  AppState(this.tasksState);

  factory AppState.initial() => AppState(TasksState.initial());

  AppState copyWith({
    TasksState tasksState,
  }) {
    return AppState (
      tasksState ?? this.tasksState,
    );
  }

}