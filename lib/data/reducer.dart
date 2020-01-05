import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/data/tasks/reducer.dart';
import 'package:pomodoro/data/user/reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
     tasksReducer(state.tasksState, action),
      userReducer(state.userState, action)
  );
}