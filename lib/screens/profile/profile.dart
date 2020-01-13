import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:pomodoro/data/user/state.dart';
import 'package:pomodoro/widgets/action_button/action_button.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';

class ProfileApp extends StatefulWidget {
  final TextEditingController displayNameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  ProfileApp({Key key, this.displayNameController, this.passwordController, this.usernameController}) : super(key: key);

  @override
  ProfileAppState createState() => ProfileAppState();
}

class ProfileAppState extends State<ProfileApp> {

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
            child: Column(
              children: <Widget>[
                Text("${vm.userState.currentUser != null ? vm.userState.currentUser.displayName : ""}. Email: ${vm.userState.currentUser != null ? vm.userState.currentUser.email : ""}"),
                ActionButton(text: "Sign Out", color: Colors.red,onTap: () async {
                  vm.signOut();
                  print("pressed");
                }),
              ],
            )
          ),
        );
      },
      converter: ViewModel.fromStore,
    );
  }
}

class ViewModel {
  final UserState userState;
  final Function() signOut;

  ViewModel({
    this.userState,
    this.signOut,
  });

  static ViewModel fromStore(Store<AppState> store) {
    return ViewModel(
      userState: store.state.userState,
      signOut: () {
        store.dispatch(signOutUser());
      },
    );
  }
}