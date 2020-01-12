import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:pomodoro/data/user/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/services/auth.dart';

class ProfileApp extends StatefulWidget {
  final TextEditingController displayNameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  ProfileApp({Key key, this.displayNameController, this.passwordController, this.usernameController}) : super(key: key);

  @override
  ProfileAppState createState() => ProfileAppState();
}

class ProfileAppState extends State<ProfileApp> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double _sidePadding = MediaQuery.of(context).size.width / 20;
    double _topPadding = MediaQuery.of(context).size.height / 20;

    return StoreConnector<AppState, ViewModel>(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            child: Text("Profile coming soon")
          ),
        );
      },
      converter: ViewModel.fromStore,
    );
  }
}

class ViewModel {
  final RegistrationScreen registrationScreen;
  final Function(String, String, String) register;
  //final Function({String displayName, String username, String password}) updateLogin;

  ViewModel({
    this.registrationScreen,
    this.register,
    //this.updateLogin,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      // Implement return.
      registrationScreen: store.state.userState.registrationScreen,
      register: (String displayName, String username, String password) {
        store.dispatch(registerUser(username, password));
      },
      //updateLogin: ({displayName, username, password}) => store.dispatch(new LoginScreenAction(displayName, username, password))
    );
  }
}