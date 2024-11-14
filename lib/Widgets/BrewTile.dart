import 'package:brew_crew/Models/Brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew brew;

  const BrewTile({super.key, required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
            backgroundImage: const AssetImage("assets/images/coffee_icon.png"),
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugar} spoons of sugar"),
        ),
      ),
    );
  }
}
