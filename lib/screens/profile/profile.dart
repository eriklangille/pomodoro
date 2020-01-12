import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:pomodoro/data/user/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/services/auth.dart';
import 'package:pomodoro/widgets/action_button/action_button.dart';
import 'package:pomodoro/widgets/entry_field/index.dart';
import 'package:pomodoro/widgets/hide_glow/hide_glow.dart';
import 'package:pomodoro/widgets/instruction_text/index.dart';

class ProfileApp extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double _sidePadding = MediaQuery.of(context).size.width / 20;
    double _topPadding = MediaQuery.of(context).size.height / 20;

    return StoreConnector<AppState, _ViewModel>(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profile", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
              padding: EdgeInsets.fromLTRB(_sidePadding, _topPadding, _sidePadding, 0),
              child: ScrollConfiguration(
                behavior: HideGlow(),
                child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InstructionText(text: "Sign up to save your tasks online and compete with others.", margin: EdgeInsets.fromLTRB(0, 0, 0, 30),),
                    EntryField(hintText: "Display Name",
                      textEditingController: vm.loginScreen.displayName,
                      focus: vm.loginScreen.focus,
                    ),
                    EntryField(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: vm.loginScreen.username,
                      entryAlert: (vm.loginScreen.usernameAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.loginScreen.usernameAlert,
                    ),
                    EntryField(
                      hintText: "Password",
                      isPassword: true,
                      textEditingController: vm.loginScreen.password,
                      entryAlert: (vm.loginScreen.passwordAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.loginScreen.passwordAlert,
                    ),
                    ActionButton(text: "Sign Up",
                      color: Colors.red,
                      onTap: () async {
                        vm.register(vm.loginScreen.displayName.text, vm.loginScreen.username.text, vm.loginScreen.password.text);
                        print(vm.loginScreen.username.text);
                        print(vm.loginScreen.password.text);
                      },
                    ),
                    InstructionText(text: "Already Registered?", margin: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                    ActionButton(text: "Sign In",
                      color: Colors.red,
                      invert: true,
                      onTap: () async {
                        dynamic result = await _auth.signInAnon();
                        if (result == null) {
                          print("error signing in.");
                        } else {
                          print('signed in');
                          print(result);
                        }
                      },
                    ),
                  ],
                ),
              )
          ),
        );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel {
  final LoginScreen loginScreen;
  final Function(String, String, String) register;
  //final Function({String displayName, String username, String password}) updateLogin;

  _ViewModel({
    this.loginScreen,
    this.register,
    //this.updateLogin,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      // Implement return.
      loginScreen: store.state.userState.loginScreen,
      register: (String displayName, String username, String password) {
        store.dispatch(loginUser(username, password));
      },
      //updateLogin: ({displayName, username, password}) => store.dispatch(new LoginScreenAction(displayName, username, password))
    );
  }
}