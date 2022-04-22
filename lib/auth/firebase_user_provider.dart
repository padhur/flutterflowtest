import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CHFlutterFirebaseUser {
  CHFlutterFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CHFlutterFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CHFlutterFirebaseUser> cHFlutterFirebaseUserStream() => FirebaseAuth
    .instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<CHFlutterFirebaseUser>(
        (user) => currentUser = CHFlutterFirebaseUser(user));
