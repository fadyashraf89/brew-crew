import 'package:brew_crew/Services/auth.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Brew Crew", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        )),
        actions: [
          Row(
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      Text("Log Out", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                onTap: () async {
                  await _authService.SignOut();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
