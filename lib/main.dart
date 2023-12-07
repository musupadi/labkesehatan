import 'package:flutter/material.dart';
import 'package:labkesehatanehatan/API/Server.dart';
import 'package:labkesehatanehatan/Dashboard.dart';
import 'package:labkesehatanehatan/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Labkes (Labolatorium SATKES)',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
