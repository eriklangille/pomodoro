import 'package:firebase_auth/firebase_auth.dart';
import 'package:pomodoro/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> get getCurrentUser => _auth.currentUser();

  Future signInEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch(e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  //Register for an account with an email.
  Future registerEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // TODO: Created document for this user.
      await DatabaseService(uid: user.uid).updateUserData(null, 0, 0); //Document Created.
      return user;
    } catch (e) {
      print(e.toString());
      return Future.error(e);
    }
  }

  //Sign out of the app.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}