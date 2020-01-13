import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro/data/user/actions.dart';
import 'package:pomodoro/data/user/state.dart';
import 'package:redux/redux.dart';
import 'package:pomodoro/data/state.dart';
import 'package:pomodoro/widgets/action_button/action_button.dart';
import 'package:pomodoro/widgets/entry_field/index.dart';
import 'package:pomodoro/widgets/hide_glow/hide_glow.dart';
import 'package:pomodoro/widgets/instruction_text/index.dart';

class RegistrationApp extends StatefulWidget {

  RegistrationApp({Key key}) : super(key: key);

  @override
  RegistrationAppState createState() => RegistrationAppState();
}

class RegistrationAppState extends State<RegistrationApp> {
  final TextEditingController displayNameController = TextEditingController();
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
            title: Text("Register", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
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
                      textEditingController: displayNameController,
                    ),
                    EntryField(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: usernameController,
                      entryAlert: (vm.registrationScreen.usernameAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.registrationScreen.usernameAlert,
                    ),
                    EntryField(
                      hintText: "Password",
                      isPassword: true,
                      textEditingController: passwordController,
                      entryAlert: (vm.registrationScreen.passwordAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.registrationScreen.passwordAlert,
                    ),
                    ActionButton(text: "Sign Up",
                      color: Colors.red,
                      onTap: () async {
                        vm.register(displayNameController.text, usernameController.text, passwordController.text);
                        print("nice");
                      },
                    ),
                    InstructionText(text: "Already Registered?", margin: EdgeInsets.fromLTRB(0, 30, 0, 20),),
                    ActionButton(text: "Sign In",
                      color: Colors.red,
                      invert: true,
                      onTap: () async {
                        Navigator.popAndPushNamed(context, '/login');
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
  final RegistrationScreen registrationScreen;
  final Function(String, String, String) register;
  //final Function({String displayName, String username, String password}) updateLogin;

  _ViewModel({
    this.registrationScreen,
    this.register,
    //this.updateLogin,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      // Implement return.
      registrationScreen: store.state.userState.registrationScreen,
      register: (String displayName, String username, String password) {
        store.dispatch(registerUser(displayName, username, password));
      },
      //updateLogin: ({displayName, username, password}) => store.dispatch(new LoginScreenAction(displayName, username, password))
    );
  }
}