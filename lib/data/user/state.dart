import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserState {
  final FirebaseUser currentUser;
  final RegistrationScreen registrationScreen;
  final LoginScreen loginScreen;

  UserState(this.currentUser, this.registrationScreen, this.loginScreen);

  factory UserState.initial() => UserState(null, RegistrationScreen.initial(), LoginScreen.initial());

}

class User {
  final String uid;

  User({this.uid});
}

class RegistrationScreen {
  final String usernameAlert;
  final String passwordAlert;

  RegistrationScreen({this.usernameAlert, this.passwordAlert});

  factory RegistrationScreen.initial() {
    return new RegistrationScreen(usernameAlert: "", passwordAlert: "",);
  }

  RegistrationScreen copyWith({
    String usernameAlert,
    String passwordAlert,
  }) {
    return RegistrationScreen(
      usernameAlert: usernameAlert ?? this.usernameAlert,
      passwordAlert: passwordAlert ?? this.passwordAlert,
    );
  }
}

class LoginScreen {
  final String usernameAlert;
  final String passwordAlert;

  LoginScreen({this.usernameAlert, this.passwordAlert});

  factory LoginScreen.initial() {
    return new LoginScreen(usernameAlert: "", passwordAlert: "",);
  }

  LoginScreen copyWith({
    String usernameAlert,
    String passwordAlert,
  }) {
    return LoginScreen(
      usernameAlert: usernameAlert ?? this.usernameAlert,
      passwordAlert: passwordAlert ?? this.passwordAlert,
    );
  }
}