import 'package:pomodoro/data/tasks/state.dart';
import 'package:pomodoro/data/user/state.dart';

class AppState {
  final TasksState tasksState;
  final UserState userState;

  AppState(this.tasksState, this.userState);

  factory AppState.initial() => AppState(TasksState.initial(), UserState.initial());

  AppState copyWith({
    TasksState tasksState,
    UserState userState,
  }) {
    return AppState (
      tasksState ?? this.tasksState,
      userState ?? this.userState,
    );
  }

}