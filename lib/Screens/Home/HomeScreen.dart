import 'package:brew_crew/Models/Brew.dart';
import 'package:brew_crew/Services/auth.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Widgets/BrewList.dart';
import 'package:brew_crew/Widgets/SettingsForm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/User.dart';
import '../Authentication/SignUp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData?>(context); // Get UserData
    return StreamProvider<List<Brew>?>.value(
      value: user != null ? DatabaseService(user.uid).brews : null,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.brown[400],
          elevation: 0.0,

          title: const Text("Brew Crew",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.person, color: Colors.white),
                          Text(
                            "Log Out",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      try {
                        await _authService.SignOut();
                        // Navigate to signup screen and replace current route
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                              (Route<dynamic> route) => false, // Remove all previous routes
                        );
                      } catch (e) {
                        // Handle logout error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error logging out: ${e.toString()}')),
                        );
                      }
                    },                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                        child: const Icon(Icons.settings, color: Colors.white),
                        onTap: () => showSettingsPanel()),
                  ),
                ],
              ),
            )
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/coffee_bg.png")
            )
          ),
            child: const BrewList()
        ),
      ),
    );
  }

  void showSettingsPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set to true
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 40,
          right: 40,
        ),
        child: const SettingsForm(),
      ),
    );
  }
}
