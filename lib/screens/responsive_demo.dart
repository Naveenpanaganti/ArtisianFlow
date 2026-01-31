import 'package:flutter/material.dart';

class ResponsiveDemo extends StatelessWidget {
  const ResponsiveDemo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Design Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (screenWidth < 600) {
            // Mobile layout
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: 100,
                  color: Colors.tealAccent,
                  child: const Center(child: Text('Mobile View')),
                ),
              ],
            );
          } else {
            // Tablet / large screen layout
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.orangeAccent,
                  child: const Center(child: Text('Tablet Left Panel')),
                ),
                Container(
                  width: 250,
                  height: 150,
                  color: Colors.tealAccent,
                  child: const Center(child: Text('Tablet Right Panel')),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
