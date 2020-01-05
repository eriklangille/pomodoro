import 'package:pomodoro/data/user/state.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:redux/redux.dart';

UserState userReducer(UserState state, action) => UserState(
  currentUserReducer(state.currentUser, action),
);

final Reducer<User> currentUserReducer = combineReducers([
  TypedReducer<User, CurrentUserAction>(_currentUser),
]);

User _currentUser(User currentUser, CurrentUserAction action) => null;