import 'package:brew_crew/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Widgets/MyAppBar.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sign In",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),),
                Container(
                  child: ElevatedButton(
                    onPressed: () async {
                      AuthService authService = AuthService();
                      User? user = await authService.signInAnonymously();
                      if (user != null) {
                        print("Successfully signed in anonymously with UID: ${user.uid}");
                        print (authService.CreateUserFromFirebaseUser(user));
                      } else {
                        print("Failed to sign in anonymously.");
                      }
                    },
                    child: const Text("Sign In Anonymously"),
                  ),

                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


}
