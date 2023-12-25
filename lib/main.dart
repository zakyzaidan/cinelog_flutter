import 'package:cinelog/login_screen.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinelog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Glory'
      ),
      home: const LoginScreen(),
    );
  }
}
