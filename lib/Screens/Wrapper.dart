import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Screens/Home/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Authentication/SignIn.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return const SignInPage();
    } else {
      return const HomeScreen();
    }
  }
}
