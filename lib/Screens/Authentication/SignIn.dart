import 'package:brew_crew/Screens/Home/HomeScreen.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../Widgets/MyAppBar.dart';
import 'SignUp.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _authService = AuthService();
  bool showPassword = false;
  IconData icon = Icons.visibility_off;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                              if (showPassword) {
                                icon = Icons.visibility;
                              } else {
                                icon = Icons.visibility_off;
                              }
                            });
                          },
                          icon: Icon(icon),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                            BorderSide(color: Colors.black.withOpacity(0.5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.black, width: 2)),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          dynamic result = await _authService.SignInWithEmailAndPassword(
                              emailController.text, passwordController.text);

                          if (result == null) {
                            // Show error message to the user (e.g., using a SnackBar)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error signing in')),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const HomeScreen(), // Pass the email to home screen
                              ),
                            );
                          }
                        }
                      },
                      child: Text("Sign In"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ?"),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SignUpPage(), // Pass the email to home screen
                              ),
                            );
                          }, child: Text("Register Now", style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold
                        ),),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
