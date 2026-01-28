import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ArtisanFlow Dashboard')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pushNamed puts the new screen on top of the stack
            Navigator.pushNamed(context, '/detail', arguments: 'Artisan #101');
          },
          child: const Text('View Artisan Details'),
        ),
      ),
    );
  }
}