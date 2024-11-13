import 'package:brew_crew/Screens/Home/HomeScreen.dart';
import 'package:brew_crew/Services/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Models/User.dart';

import 'Authentication/Authentication.dart'; // Import your UserData model

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return AuthenticationScreen();
    } else {
      return HomeScreen();
    }
  }
}