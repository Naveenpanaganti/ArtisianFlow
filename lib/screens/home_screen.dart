import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/info_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ArtisanFlow')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome to ArtisanFlow', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text('Discover artisans and handcrafted products in your community.'),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: CustomButton(label: 'Catalog', onPressed: () => Navigator.pushNamed(context, '/scrollable'))),
                      const SizedBox(width: 12),
                      CustomButton(label: 'Profile', onPressed: () => Navigator.pushNamed(context, '/detail')),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Quick Actions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            InfoCard(title: 'My Dashboard', subtitle: 'View your items and activity', icon: Icons.dashboard),
            InfoCard(title: 'User Input Form', subtitle: 'Try the input form example', icon: Icons.edit),
            InfoCard(title: 'State Demo', subtitle: 'See setState in action', icon: Icons.toggle_on),
            const SizedBox(height: 20),
            Center(child: CustomButton(label: 'Open Form', onPressed: () => Navigator.pushNamed(context, '/userform'))),
          ],
        ),
      ),
    );
  }
}