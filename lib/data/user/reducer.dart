import 'package:pomodoro/data/user/state.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';

UserState userReducer(UserState state, action) => UserState(
  currentUserReducer(state.currentUser, action),
  loginScreenReducer(state.registrationScreen, action),
);

final Reducer<FirebaseUser> currentUserReducer = combineReducers([
  TypedReducer<FirebaseUser, CurrentUserAction>(_currentUser),
  TypedReducer<FirebaseUser, SetUserAction>(_setUser)
]);

FirebaseUser _currentUser(FirebaseUser currentUser, CurrentUserAction action) => null;

FirebaseUser _setUser(FirebaseUser user, SetUserAction action) => action.user;

final Reducer<RegistrationScreen> loginScreenReducer = combineReducers([
  TypedReducer<RegistrationScreen, RegistrationScreenAction>(_displayName),
  TypedReducer<RegistrationScreen, RegistrationFailedAction>(_registrationFailed)
]);

RegistrationScreen _registrationFailed(RegistrationScreen loginScreen, RegistrationFailedAction action) => loginScreen.copyWith(usernameAlert: action.usernameAlert, passwordAlert: action.passwordAlert);

RegistrationScreen _displayName(RegistrationScreen loginScreen, RegistrationScreenAction action) => null;