import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/data/tasks/reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
     tasksReducer(state.tasksState, action)
  );
}