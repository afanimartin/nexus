import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class NexusFirebaseUser {
  NexusFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

NexusFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<NexusFirebaseUser> nexusFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<NexusFirebaseUser>((user) => currentUser = NexusFirebaseUser(user));
