import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.email ?? 'User'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('items').orderBy('createdAt', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) return const Center(child: Text('No items yet'));
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final d = docs[index];
                      return ListTile(
                        title: Text(d['title'] ?? 'Untitled'),
                        subtitle: Text(d['description'] ?? ''),
                        onTap: () => Navigator.pushNamed(context, '/detail', arguments: d.id),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Map<String, String>>(context: context, builder: (context) {
            final tCtrl = TextEditingController();
            final dCtrl = TextEditingController();
            return AlertDialog(
              title: const Text('Add Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: tCtrl, decoration: const InputDecoration(labelText: 'Title')),
                  TextField(controller: dCtrl, decoration: const InputDecoration(labelText: 'Description')),
                ],
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                ElevatedButton(onPressed: () => Navigator.pop(context, {'title': tCtrl.text, 'description': dCtrl.text}), child: const Text('Add')),
              ],
            );
          });
          if (result != null) {
            await FirebaseFirestore.instance.collection('items').add({
              'title': result['title'],
              'description': result['description'],
              'createdBy': FirebaseAuth.instance.currentUser?.uid,
              'createdAt': FieldValue.serverTimestamp(),
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
