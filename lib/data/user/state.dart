class UserState {
  final User currentUser;

  UserState(this.currentUser);

  factory UserState.initial() => UserState(null);

}

class User {
  final String uid;

  User({this.uid});
}