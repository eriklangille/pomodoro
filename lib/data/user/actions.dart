import 'package:pomodoro/redux.dart';
import 'package:pomodoro/util/parseerror.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/services/auth.dart';

class CurrentUserAction {
}

class SetUserAction {
  final FirebaseUser user;

  SetUserAction(this.user);
}

ThunkAction registerUser(String displayName, String username, String password) {
  return (Store store) async {
    new Future(() async{
      AuthService _auth = new AuthService();
      store.dispatch(new StartLoadingAction());
      _auth.registerEmail(username, password).then((loginResponse) {
        FirebaseUser _user = loginResponse;
        UserUpdateInfo _info = new UserUpdateInfo();
        _info.displayName = displayName;
        _user.updateProfile(_info);
        store.dispatch(new LoginSuccessAction());
        _auth.getCurrentUser.then((user) {
          store.dispatch(new SetUserAction(user));
        });
        store.dispatch(new RegistrationFailedAction(passwordAlert: "", usernameAlert: ""));
        navigatorKey.currentState.maybePop();
      }, onError: (error) {
        ErrorMessage _error = ParseError.registerError(error.code);
        print(_error.message);
        if(_error.type == "username") {
          store.dispatch(new RegistrationFailedAction(usernameAlert: _error.message, passwordAlert: ""));
        } else if(_error.type == "password") {
          store.dispatch(new RegistrationFailedAction(passwordAlert: _error.message, usernameAlert: ""));
        }
      });
    });
  };
}

ThunkAction loginUser(String username, String password) {
  return (Store store) async {
    new Future(() async{
      AuthService _auth = new AuthService();
      store.dispatch(new StartLoadingAction());
      _auth.signInEmail(username, password).then((loginResponse) {
        store.dispatch(new LoginSuccessAction());
        store.dispatch(new SetUserAction(loginResponse));
        navigatorKey.currentState.maybePop();
      }, onError: (error) {
        ErrorMessage _error = ParseError.loginError(error.code);
        print(error);
        print(_error.message);
        if(_error.type == "username") {
          store.dispatch(new LoginFailedAction(usernameAlert: _error.message, passwordAlert: ""));
        } else if(_error.type == "password") {
          store.dispatch(new LoginFailedAction(passwordAlert: _error.message, usernameAlert: ""));
        }
      });
    });
  };
}

ThunkAction refreshUser() {
  return (Store store) async {
    new Future(() async{
      AuthService _auth = new AuthService();
      _auth.getCurrentUser.then((user) {
        store.dispatch(new SetUserAction(user));
      });
    });
  };
}

ThunkAction signOutUser() {
  return (Store store) async {
    new Future(() async{
      AuthService _auth = new AuthService();
      _auth.signOut().then((val) {
        print("yoy");
        store.dispatch(new SetUserAction(null));

      });
    });
  };
}

class RegistrationScreenAction {
}

class StartLoadingAction {

}

class LoginSuccessAction {
}

class RegistrationFailedAction {
  final String usernameAlert;
  final String passwordAlert;

  RegistrationFailedAction({this.usernameAlert, this.passwordAlert});
}

class LoginFailedAction {
  final String usernameAlert;
  final String passwordAlert;

  LoginFailedAction({this.usernameAlert, this.passwordAlert});
}