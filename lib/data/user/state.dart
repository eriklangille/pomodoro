import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState {
  final FirebaseUser currentUser;
  final LoginScreen loginScreen;

  UserState(this.currentUser, this.loginScreen);

  factory UserState.initial() => UserState(null, LoginScreen.initial());

}

class User {
  final String uid;

  User({this.uid});
}

class LoginScreen {
  final TextEditingController displayName;
  final TextEditingController username;
  final TextEditingController password;
  final String usernameAlert;
  final String passwordAlert;
  final FocusNode focus;

  LoginScreen({this.displayName, this.username, this.password, this.focus, this.usernameAlert, this.passwordAlert});

  factory LoginScreen.initial() {
    return new LoginScreen(displayName: new TextEditingController(), username: new TextEditingController(), password: new TextEditingController(), focus: new FocusNode(), usernameAlert: "", passwordAlert: "",);
  }

  LoginScreen copyWith({
    TextEditingController displayName,
    TextEditingController username,
    TextEditingController password,
    FocusNode focus,
    String usernameAlert,
    String passwordAlert,
  }) {
    return LoginScreen(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      password: password ?? this.password,
      focus: focus ?? this.focus,
      usernameAlert: usernameAlert ?? this.usernameAlert,
      passwordAlert: passwordAlert ?? this.passwordAlert,
    );
  }
}