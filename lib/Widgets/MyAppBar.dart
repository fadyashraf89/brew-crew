import 'package:flutter/material.dart';
AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.brown[400],
    automaticallyImplyLeading: false,
    elevation: 0.0,
    title: Text("Brew Crew", style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold
    )),
  );
}