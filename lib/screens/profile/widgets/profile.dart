import 'package:flutter/material.dart';
import 'package:pomodoro/services/auth.dart';

class ProfileApp extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: RaisedButton(
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              print("error signing in.");
            } else {
              print('signed in');
              print(result);
            }
          },
        ),
      ),
    );
  }
}