import 'package:brew_crew/Screens/Authentication/Authentication.dart';
import 'package:brew_crew/Screens/Home/HomeScreen.dart';
import 'package:brew_crew/Services/SignIn.dart';
import 'package:flutter/material.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
