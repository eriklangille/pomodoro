import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState {
  final FirebaseUser currentUser;
  final RegistrationScreen registrationScreen;

  UserState(this.currentUser, this.registrationScreen);

  factory UserState.initial() => UserState(null, RegistrationScreen.initial());

}

class User {
  final String uid;

  User({this.uid});
}

class RegistrationScreen {
  final String usernameAlert;
  final String passwordAlert;
  final FocusNode focus;

  RegistrationScreen({this.focus, this.usernameAlert, this.passwordAlert});

  factory RegistrationScreen.initial() {
    return new RegistrationScreen(focus: new FocusNode(), usernameAlert: "", passwordAlert: "",);
  }

  RegistrationScreen copyWith({
    FocusNode focus,
    String usernameAlert,
    String passwordAlert,
  }) {
    return RegistrationScreen(
      focus: focus ?? this.focus,
      usernameAlert: usernameAlert ?? this.usernameAlert,
      passwordAlert: passwordAlert ?? this.passwordAlert,
    );
  }
}