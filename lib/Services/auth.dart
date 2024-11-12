import 'package:brew_crew/Models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Anonymous Sign-In
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      print("Signed in as: ${user?.uid}");
      return user;
    } catch (e) {
      print("Error in anonymous sign-in: $e");
      if (e is FirebaseAuthException) {
        print("FirebaseAuthException code: ${e.code}, message: ${e.message}");
      }
      return null;
    }
  }
  Stream<UserData?> get user{
    return _auth.authStateChanges().map(CreateUserFromFirebaseUser);

  }

  UserData? CreateUserFromFirebaseUser(User? user) {
    return user != null ? UserData(uid: user.uid) : null;
  }
}

