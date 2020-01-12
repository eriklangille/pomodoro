import 'package:pomodoro/data/user/state.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserState userReducer(UserState state, action) => UserState(
  currentUserReducer(state.currentUser, action),
  loginScreenReducer(state.loginScreen, action),
);

final Reducer<FirebaseUser> currentUserReducer = combineReducers([
  TypedReducer<FirebaseUser, CurrentUserAction>(_currentUser),
  TypedReducer<FirebaseUser, SetUserAction>(_setUser)
]);

FirebaseUser _currentUser(FirebaseUser currentUser, CurrentUserAction action) => null;

FirebaseUser _setUser(FirebaseUser user, SetUserAction action) => action.user;

final Reducer<LoginScreen> loginScreenReducer = combineReducers([
  TypedReducer<LoginScreen, LoginScreenAction>(_displayName),
  TypedReducer<LoginScreen, LoginFailedAction>(_loginFailed)
]);

LoginScreen _loginFailed(LoginScreen loginScreen, LoginFailedAction action) => loginScreen.copyWith(usernameAlert: action.usernameAlert, passwordAlert: action.passwordAlert);

LoginScreen _displayName(LoginScreen loginScreen, LoginScreenAction action) => loginScreen.copyWith(displayName: action.displayName);