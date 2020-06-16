import 'package:airtask/screens/home_screen.dart';
import 'package:airtask/services/service_locator.dart';
import 'package:flutter/material.dart';

//TODO: Edit group
//TODO: Help buttons
//TODO: Checked off tasks

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airtask',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}