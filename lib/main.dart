import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart'; // Import your new screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArtisanFlow',
      theme: ThemeData(primarySwatch: Colors.brown, useMaterial3: true),
      home: const WelcomeScreen(), // Set the WelcomeScreen as home
    );
  }
}