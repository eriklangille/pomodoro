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

ThunkAction loginUser(String username, String password) {
  return (Store store) async {
    new Future(() async{
      AuthService _auth = new AuthService();
      store.dispatch(new StartLoadingAction());
      _auth.registerEmail(username, password).then((loginResponse) {
        store.dispatch(new LoginSuccessAction());
        store.dispatch(new SetUserAction(loginResponse));
        store.dispatch(new LoginFailedAction(passwordAlert: "", usernameAlert: ""));
//        Keys.navKey.currentState.pushNamed(Routes.homeScreen);
      }, onError: (error) {
        ErrorMessage _error = ParseError.registerError(error.code);
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

class LoginScreenAction {
  final TextEditingController displayName;
  final TextEditingController username;
  final TextEditingController password;

  LoginScreenAction(this.displayName, this.username, this.password);
}

class StartLoadingAction {

}

class LoginSuccessAction {
}

class LoginFailedAction {
  final String usernameAlert;
  final String passwordAlert;

  LoginFailedAction({this.usernameAlert, this.passwordAlert});
}