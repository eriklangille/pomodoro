import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:pomodoro/data/user/state.dart';
import 'package:pomodoro/redux.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/widgets/action_button/action_button.dart';
import 'package:pomodoro/widgets/entry_field/index.dart';
import 'package:pomodoro/widgets/hide_glow/hide_glow.dart';
import 'package:pomodoro/widgets/instruction_text/index.dart';

class LoginApp extends StatefulWidget {

  LoginApp({Key key,}) : super(key: key);

  @override
  LoginAppState createState() => LoginAppState();
}

class LoginAppState extends State<LoginApp> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _sidePadding = MediaQuery.of(context).size.width / 20;
    double _topPadding = MediaQuery.of(context).size.height / 20;

    return StoreConnector<AppState, _ViewModel>(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign In", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                         Container(
                            child: Column(
                              children: <Widget>[
                                InstructionText(text: "Sign in to access your saved tasks and groups.", margin: EdgeInsets.fromLTRB(0, 0, 0, 30),),
                                EntryField(
                                  hintText: "Email",
                                  keyboardType: TextInputType.emailAddress,
                                  textEditingController: usernameController,
                                  entryAlert: (vm.loginScreen.usernameAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                                  alertText: vm.loginScreen.usernameAlert,
                                ),
                                EntryField(
                                  hintText: "Password",
                                  isPassword: true,
                                  textEditingController: passwordController,
                                  entryAlert: (vm.loginScreen.passwordAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                                  alertText: vm.loginScreen.passwordAlert,
                                ),
                              ],
                            ),
                          ),
                        ActionButton(text: "Sign In",
                          color: Colors.red,
                          invert: false,
                          onTap: () async {
                            vm.login(usernameController.text, passwordController.text);
//                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ],
                ),
              )
          ),
        );
      },
      converter: _ViewModel.fromStore,
      onDidChange: (vm) {
        if(vm.userState.currentUser != null) {
          Navigator.pushReplacementNamed(context, '/');
        }
      },
    );
  }
}

class _ViewModel {
  final LoginScreen loginScreen;
  final UserState userState;
  final Function(String, String) login;
  //final Function({String displayName, String username, String password}) updateLogin;

  _ViewModel({
    this.loginScreen,
    this.userState,
    this.login,
    //this.updateLogin,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      // Implement return.
      loginScreen: store.state.userState.loginScreen,
      userState: store.state.userState,
      login: (String username, String password) {
        store.dispatch(loginUser(username, password));
      },
      //updateLogin: ({displayName, username, password}) => store.dispatch(new LoginScreenAction(displayName, username, password))
    );
  }
}