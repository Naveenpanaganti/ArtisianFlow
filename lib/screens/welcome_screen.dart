import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String message = "Welcome to ArtisanFlow";
  Color buttonColor = Colors.blue;

  void _handlePress() {
    setState(() {
      message = "Ready to manage your craft?";
      buttonColor = Colors.orange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ArtisanFlow")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.brush, size: 80, color: Colors.brown),
            const SizedBox(height: 20),
            Text(message, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: _handlePress,
              child: const Text("Get Started", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}