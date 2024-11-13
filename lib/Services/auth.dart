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

  // Make this stream nullable
  Stream<UserData?>? get MyUser { // Make this explicitly nullable
    return _auth.authStateChanges().map(CreateUserFromFirebaseUser);
  }


  UserData? CreateUserFromFirebaseUser(User? user) {
    return user != null ? UserData(user.uid) : null;
  }

  Future SignOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<UserData?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return CreateUserFromFirebaseUser(user); // Return UserData object
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<UserData?> SignInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      // If sign-in is successful, return UserData
      return CreateUserFromFirebaseUser(credential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    // If sign-in fails or there's an exception, return null
    return null;
  }

}



