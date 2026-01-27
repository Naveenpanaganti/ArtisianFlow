import 'package:flutter/material.dart';

// 1. STATELESS WIDGET: For static content that doesn't change
class HeaderWidget extends StatelessWidget {
  final String title;
  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blueAccent,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// 2. STATEFUL WIDGET: For content that reacts to user interaction
class InteractiveToggle extends StatefulWidget {
  const InteractiveToggle({super.key});

  @override
  _InteractiveToggleState createState() => _InteractiveToggleState();
}

class _InteractiveToggleState extends State<InteractiveToggle> {
  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          _isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : Colors.grey,
          size: 100,
        ),
        ElevatedButton(
          onPressed: _toggleFavorite,
          child: Text(_isFavorite ? "Remove from Favorites" : "Add to Favorites"),
        ),
      ],
    );
  }
}

// 3. MAIN PAGE: Combining both
class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stateless vs Stateful")),
      body: Column(
        children: const [
          HeaderWidget(title: "ArtisanFlow: Static Header"), // Stateless
          Expanded(
            child: Center(child: InteractiveToggle()), // Stateful
          ),
        ],
      ),
    );
  }
}