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

class RegistrationApp extends StatefulWidget {
  final TextEditingController displayNameController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  RegistrationApp({Key key, this.displayNameController, this.passwordController, this.usernameController}) : super(key: key);

  @override
  RegistrationAppState createState() => RegistrationAppState();
}

class RegistrationAppState extends State<RegistrationApp> {
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
              padding: EdgeInsets.fromLTRB(_sidePadding, _topPadding, _sidePadding, 0),
              child: ScrollConfiguration(
                behavior: HideGlow(),
                child: ListView(
//          crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InstructionText(text: "Sign up to save your tasks online and compete with others.", margin: EdgeInsets.fromLTRB(0, 0, 0, 30),),
                    EntryField(hintText: "Display Name",
                      textEditingController: widget.displayNameController,
                      focus: vm.registrationScreen.focus,
                    ),
                    EntryField(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textEditingController: widget.usernameController,
                      entryAlert: (vm.registrationScreen.usernameAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.registrationScreen.usernameAlert,
                    ),
                    EntryField(
                      hintText: "Password",
                      isPassword: true,
                      textEditingController: widget.passwordController,
                      entryAlert: (vm.registrationScreen.passwordAlert ?? "") != "" ? EntryAlert.error : EntryAlert.none,
                      alertText: vm.registrationScreen.passwordAlert,
                    ),
                    ActionButton(text: "Sign Up",
                      color: Colors.red,
                      onTap: () async {
                        vm.register(widget.displayNameController.text, widget.usernameController.text, widget.passwordController.text);
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