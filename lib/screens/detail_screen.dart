import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Receiving arguments from the previous screen
    final artisanArg = ModalRoute.of(context)!.settings.arguments;
    final artisanId = artisanArg is String ? artisanArg : artisanArg?.toString();

    if (artisanId == null || artisanId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Artisan Profile')),
        body: const Center(child: Text('No artisan id provided')),
      );
    }

    final docRef = FirebaseFirestore.instance.collection('items').doc(artisanId);

    return Scaffold(
      appBar: AppBar(title: const Text('Artisan Profile')),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: docRef.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final doc = snapshot.data;
          if (doc == null || !doc.exists) {
            return const Center(child: Text('Item not found'));
          }

          final data = doc.data()!;
          final title = data['title']?.toString() ?? 'No title';
          final description = data['description']?.toString() ?? 'No description';
          final createdBy = data['createdBy']?.toString() ?? 'Unknown';
          final createdAtRaw = data['createdAt'];
          String createdAtStr = 'Unknown date';
          if (createdAtRaw is Timestamp) {
            createdAtStr = (createdAtRaw.toDate()).toLocal().toString();
          } else if (createdAtRaw is String) {
            createdAtStr = createdAtRaw;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('By: $createdBy', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 8),
                Text('Created: $createdAtStr', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 16),
                Text(description, style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (c) => AlertDialog(
                            title: const Text('Delete'),
                            content: const Text('Delete this item permanently?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                              TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Delete')),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          try {
                            await docRef.delete();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item deleted')));
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
                            }
                          }
                        }
                      },
                      child: const Icon(Icons.delete_forever),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}