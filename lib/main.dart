import 'package:brew_crew/Models/User.dart'; // Import your UserData model
import 'package:brew_crew/Screens/Wrapper.dart';
import 'package:brew_crew/Services/auth.dart'; // Import your AuthService
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BrewCrew());
}

class BrewCrew extends StatelessWidget {
  const BrewCrew({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData?>(
      create: (_) => AuthService().MyUser, // Use 'create' instead of 'value'
      initialData: null,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
